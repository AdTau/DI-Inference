  %DESCRIPTION: Function that estimates the directed information measure
  %(Massey, 90) via the CTW algorithm (Jiao et al., 2013) at different
  %delays betweeen simultaneously discrete signals across different (1) intervals/sliding time
  %windows and (2) trials.

  %INPUTS
  %1.NODE_1_MAT-> (num_trials x trial length) signal matrix of node 1
  %2.NODE_2_MAT-> (num_trials x trial length) signal matrix of node 2
  %3.N->Alphabet size of the time series
  %4.M->Markovian memory of the time time series
  %5.interval_width->size of interval in time steps.
  %6.num_delays->number of delays to be tested.
  %7.delay_step->number of time steps between tested delays
  %8.num_surs->number of surrogate computations (one for each cyclic shift) 
  
  %OUTPUTS:
  %1.DI_ORIGINAL_MAT-> (num_trials x num_intervals x num_delays) matrix of DI
  %computations
  %2.DI_SURROGATES_MAT-> (num_trials x num_intervals x num_delays x num_surs) matrix of DI
  %computations
  
  %NOTE: The function 'compute_DI_m' and the sub-functions called therein ('CTW_code' subfolder) are based on the MATLAB implementation of the 
  %universal directed information estimators in Jiantao Jiao, Haim H. Permuter, Lei Zhao, Young-Han Kim, 
  %and Tsachy Weissman. "Universal estimation of directed information." IEEE Transactions on Information Theory 59, no. 10 (2013): 6220-6242. 
  %and slightlyu modifications of the Github code that can be found here:
  %https://github.com/EEthinker/Universal_directed_information



function [DI_ORIGINAL_MAT, DI_SURROGATES_MAT]=DI_computation_per_pair(NODE_1_MAT,NODE_2_MAT,N,M,interval_width,interval_step,num_delays,delay_step,num_surs)

% SET Path%%%%%%%%%%%%%%%%%%
path00=pwd;
aux=find(path00=='/');
path0=path00(1:aux(end));


%%%%Set surrogate circular shifts%%%%%%%%%%%%%%%%%%%%%%%%%
%the whole interval lasts 250 time steps so here I chose 
%to start the shifts at 0.2 of the whole time length
vec_aux=linspace(50,200,num_surs);
sur_shifts=round(vec_aux);  



%%CTW ALGORITHM PARAMETERS%%%%%%%%%%%%%%%%%%%%
%%%%%CTW code%%%%%%%%%
path_CTW=[path00 '/CTW_code'];
addpath(path_CTW)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Alphabet
Nx=N;
%Markovian memory
autocovariance_memory=M;
crosscovariance_memory=M;
%specific algorithm paramters
start_ratio=0.5;
prob=0;
flag=0;
alg='E3';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%Extract matrix dimensions and set intervals to consider%%%%%%%%%%%%%
num_trials=size(NODE_1_MAT,1);
trial_length=size(NODE_1_MAT,2);
intervals=interval_width:interval_step:trial_length; 
num_intervals=length(intervals);


%Initialize matrices
DI_ORIGINAL_MAT=zeros(num_trials,num_intervals, num_delays);
DI_SURROGATES_MAT=zeros(num_trials,num_intervals, num_delays, num_surs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

               %Trial Loop%%%%%%%%%%%%%%%%%%%%%
               for trial=1:num_trials;

                     %Extract sequences per trial%%%%%%%%
                      X=NODE_1_MAT(trial,:);
                      Y=NODE_2_MAT(trial,:);

                          %Interval Loop%%%%%%%%%%%%%%%%%%%%%%%%%
                          for k=1:num_intervals
                          
                                %Delay loop%%%%%%%%%%%%%%%%%%%
                                cont_delay=0;  
                                
                                for delay=0:delay_step:num_delays*delay_step
                                    
                                    cont_delay=cont_delay+1;
                                    
                                    %Truncate binary sequences to account
                                    %for delays
                                    ini_x=intervals(k)-interval_width+1;
                                    fi_x=intervals(k)-delay;
                                    ini_y=intervals(k)-interval_width+1+delay;
                                    fi_y=intervals(k);
                                    Xseq=X(ini_x:fi_x);
                                    Yseq=Y(ini_y:fi_y);
                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                                  
                                    %DIRECTED INFORMATION computation and storage
                                    DI= compute_DI_m(Xseq,Yseq,Nx,autocovariance_memory,crosscovariance_memory,alg,start_ratio,prob,flag);
                                    var=mean(DI(end-interval_width/2:end));
                                    DI_ORIGINAL_MAT(trial,k,cont_delay)=var;
                                    %%%%%%%%%%%%%%%%%%

                                    %Surrogate computation loop%%%%%%%%%%%%%%%%%%%%%%
                                    for sur=1:num_surs

                                         %circular shifted surrogate sequence
                                         Yseq_sur=circshift(Yseq',sur_shifts(sur));
                                         
                                         %surrogate DI computation and storage                       
                                         DI=compute_DI_m(Xseq,Yseq_sur',Nx,autocovariance_memory,crosscovariance_memory,alg,start_ratio,prob,flag);  
                                         var=mean(DI(end-interval_width/2:end));     
                                         DI_SURROGATES_MAT(trial,k,cont_delay,sur)=var;
                                         %%%%%%%%%%%%%%%%%%%%%%%%%
                                    end
                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


                                end
                                %%%%%%%%%%%%%%%%%%%%%%%%%
                          end

               end

end
                                     
      

          

