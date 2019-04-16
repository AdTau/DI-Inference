%Copyright (C) 2019, A. Tauste Campo
%Contact details: adria.tauste@gmail.com
%This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License v2.0 as published by the Free Software Foundation.
%This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License v2.0 for more details.
%You should have received a copy of the GNU General Public License v2.0 along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.



%DESCRIPTION: Test file where the DI inference method with specific paramters is tested in 3
%basic simulated stochastic models: 
%1. Model with unidirectional coupling
%2. Model with bidirectional coupling
%3. Model with no coupling

%These models are analyzed as a function of different parameters to obtain the performance results illustrated in Fig. S5 of the
%article:
%A. Tauste Campo, Y. Vázquez, M. Àlvarez, A. Zainos, R. Rossi-Pool, G. Deco, R Romo. 
%"Feed-forward information and zero-lag synchronization in the sensory thalamocortical circuit are modulated during stimulus perception", 
%PNAS, 116(15), pp. 7513-22, 2019.



clc
clear;
close all;


%%%%MODEL SIMULATION PARAMETERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%General parameters
   L=250; %Time series length
   model_num=3; %Number of model 1->Unidirectional
                %Number of model 2->Bidirectional
                %Number of model 3->No coupling
      
        switch model_num

            case 1
            %%%MODEL 1: Unidirectional Model X->Y
            %Stochastic/probability parameters 
             delay=8; %Coupling delay X-Y
             P_XX_0_1=0.95; %Probability of generating X_i=0 given X_{i-1}=1.
             P_XX_1_0=0.04; %Probability of generating X_i=1 given X_{i-1}=0.
             epsilon1=0.013; %Probability of generating Y_i=1 given X_{i-delay}=0.
             epsilon2=0.35;%Probability of generating Y_i=0 given X_{i-delay}=1.
             %Time series initialization
             X(1,:)=zeros(1, L);
             Y(1,:)=zeros(1, L);
             %Time realizations for 'X' conditional probability in X_i|X_{i-1}
             P_X_0=rand(1,L); %conditioned on 'X_{i-1}=0'
             P_X_1=rand(1,L); %conditioned on 'X_{i-1}=1'
             %Time realizations for 'Channel' conditional probabilities Y_i|X{i-delay}
             P_eps1=rand(1,L); %conditioned on 'X_i=0'
             P_eps2=rand(1,L); %conditioned on 'X_i=1'


             %Simulation of pair (X,Y)
                   for i=2:L 
                         %Realization of time series X
                         X(1,i)=((X(1,i-1)==1)&&(P_X_1(1,i)>P_XX_0_1))||((X(1,i-1)==0)&&(P_X_0(1,i)<=P_XX_1_0));
                         %Realization of time series X
                         if i>delay
                         Y(1,i)=((X(1,i-delay)==0)&&(P_eps1(1,i)<=epsilon1))||((X(1,i-delay)==1)&&(P_eps2(1,i)<=1-epsilon2));
                         end                 
                    end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 2
            %%%MODEL 3: Bidirectional Model%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            epsilon_1=0.013; %Probability of generating Y_i=1 given X_{i-delay}=0 and X_i=1 given Y_{i-delay}=0
            epsilon2=0.35;%Probability of generating Y_i=0 given X_{i-delay}=1 and X_i=0 given Y_{i-delay}=1
            delay_X_Y=8; %Coupling delay X_Y
            delay_Y_X=10; %Coupling delay X_Y
            %Time series initialization
             X(1,:)=zeros(1, L);
             Y(1,:)=zeros(1, L);
             %Time realizations for 'Channel' conditional probabilities Y_i|X{i-delay}
             P_eps1=rand(1,L); %conditioned on 'X_i=0'
             P_eps2=rand(1,L); %conditioned on 'X_i=1'
             %Time realizations for 'Channel' conditional probabilities X_i|Y{i-delay}
             P_eps21=rand(1,L); %conditioned on 'Y_i=0'
             P_eps22=rand(1,L); %conditioned on 'Y_i=1'

               %Simulation of pair (X,Y)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   for i=2:L
                           if i>delay_X_Y
                              Y(1,i)=((X(1,i-delay_X_Y)==0)&&(P_eps1(1,i)<=epsilon_1))||((X(1,i-delay_X_Y)==1)&&(P_eps2(1,i)<=1-epsilon2));
                           end
                           if i>delay_Y_X
                              X(1,i)=((Y(1,i-delay_Y_X)==0)&&(P_eps21(1,i)<=epsilon_1))||((Y(1,i-delay_Y_X)==1)&&(P_eps22(1,i)<=1-epsilon2));
                           end
                   end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

            case 3
            %%%MODEL 3: Model with NO coupling%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Stochastic/probability parameters 
             P_XX_0_1=0.95; %Probability of generating X_i=0 given X_{i-1}=1.
             P_YY_0_1=0.95; %Probability of generating Y_i=0 given Y_{i-1}=1. %Non-equal alternative: P_YY_0_1=P_YY_0_1+((-1).^(rand>0.5))*rand*0.05;
             P_XX_1_0=0.04; %Probability of generating X_i=1 given X_{i-1}=0.
             P_YY_1_0=0.04; %Probability of generating X_i=1 given X_{i-1}=0. %Non-equal alternative: P_YY_1_0=P_XX_1_0+((-1).^(rand>0.5))*rand*0.05;
             %Time series initialization
             X(1,:)=zeros(1, L);
             Y(1,:)=zeros(1, L);
             %Time realizations for 'X' conditional probability in X_i|X_{i-1}
             P_X_0=rand(1,L); %conditioned on 'X_{i-1}=0'
             P_X_1=rand(1,L); %conditioned on 'X_{i-1}=1'
             %Time realizations for 'Y' conditional probability in Y_i|Y_{i-1}
             P_Y_0=rand(1,L); %conditioned on 'Y_{i-1}=0'
             P_Y_1=rand(1,L); %conditioned on 'Y_{i-1}=1'

             %Simulation of pair (X,Y)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   for i=2:L 
                         %Realization of time series X
                         X(1,i)=((X(1,i-1)==1)&&(P_X_1(1,i)>P_XX_0_1))||((X(1,i-1)==0)&&(P_X_0(1,i)<=P_XX_1_0));
                         %Realization of time series X
                         Y(1,i)=((Y(1,i-1)==1)&&(P_Y_1(1,i)>P_YY_0_1))||((Y(1,i-1)==0)&&(P_Y_0(1,i)<=P_YY_1_0));
                    end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

        end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %DIRECTIONAL INFORMATION (DI) INFERENCE


   %1. PARAMETERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %1.1 GENERAL: INTERVAL SUBDIVISIONS
       interval_width=L; %Take interval to be equal to the whole time series length
       interval_step=L; %Since interval is equal to the whole time series length, step is equal the whole length as well
       num_delays=10; %Number of equispaced delays starting from delay=0
       delay_step=2;  %Delay equidistance in bins. 

       %1.2. CONTEXT-TREE WEIGHTING (CTW) ALGORITHM
        N=2; %Time serIes alphabet size
        M=0; %Maximum memory length for the algorithm
    
       %1.3. STATISTIC SIGNIFICANCE 
        min_shift=L/5;
        max_shift=4*L/5;
        num_surs=20; %Number of surrogate samples (using circular shifts) to generate the null hypothesis
        significance_level=0.05; %Significance level
        
        
  %2. DI COMPUTATION and TESTING X-Y %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      [DI_ORIGINAL, DI_SURROGATES]=DI_computation_per_pair(X,Y,N,M,interval_width,interval_step,num_delays,delay_step,min_shift, max_shift,num_surs);
      [PVAL,MAX_DELAY_X_Y]= DI_significance_test(DI_ORIGINAL, DI_SURROGATES, delay_step,num_surs);   
      SIGN_X_Y=PVAL<significance_level;
      fprintf('DI_X_Y significance=%d\nDelay_X_Y=%d\n',SIGN_X_Y,MAX_DELAY_X_Y)
   
      
   %3. DI COMPUTATION and TESTING Y-X %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      [DI_ORIGINAL, DI_SURROGATES]=DI_computation_per_pair(Y,X,N,M,interval_width,interval_step,num_delays,delay_step,min_shift, max_shift,num_surs);
      [PVAL,MAX_DELAY_Y_X]= DI_significance_test(DI_ORIGINAL, DI_SURROGATES, delay_step,num_surs);   
      SIGN_Y_X=PVAL<significance_level;
      fprintf('DI_Y_X significance=%d \nDelay_Y_X=%d\n',SIGN_Y_X,MAX_DELAY_Y_X)    
      
      
      

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


