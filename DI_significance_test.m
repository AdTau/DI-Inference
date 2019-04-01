%DESCRIPTION: Function that estimates the Directional Information (DI)
%through the significance of a single-trial bbased statsitic, T, that is defined as
%T=max_{\delta} I_{\delta=1:max_delay}(X^N->Y^N),
%where I_{t}(X^N->Y^N) is the directed information measure computed for a time
%delay 't' during a trial epoch.


%INPUTS:%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1. DI_ORIGINAL_MAT-> (num_trials x num_intervals x num_delays) matrix of DI
%computations
%2. DI_SURROGATES_MAT-> (num_trials x num_intervals x num_delays x num_surs) matrix of DI
%computations
%3. delay_step->difefrence in delays
%num_surs=number of surrogates
  
  
%OUTPUTS:%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1. PVAL_MAT-> (num_trials x num_intervals ) matrix of p-values for DI computations
%2. DELAY_MAT-> (num_trials x num_intervals) matrix of delays for DI
%computations


%REFERENCE:
%Adrià Tauste Campo, Yuriria Vázquez, Manuel Álvarez, Antonio Zainos, Román Rossi-Pool, Gustavo Deco, and Ranulfo Romo,
%"Feed-forward information and zero-lag synchronization
%in the sensory thalamocortical circuit are modulated during stimulus
%perception", PNAS, 2019 (Supplementary Infortmation)


function  [PVAL_MAT,DELAY_MAT, T, H0]= DI_significance_test(DI_ORIGINAL_MAT, DI_SURROGATES_MAT, delay_step,num_surs)
   
 
%Construct the original value of T for each trial and interval
[T, ind_delays]=max(DI_ORIGINAL_MAT,[],3);

%convert indeces into delays/lags (accounting for zero delay/lags).
DELAY_MAT=delay_step*(ind_delays-1);

%Construct the reference distribution H0 of T out of the surrogate estimates:
H0=max(DI_SURROGATES_MAT,[],3);

%Extract matriz dimensions
num_trials=size(T,1);
num_intervals=size(T,2);
PVAL_MAT=zeros(num_trials, num_intervals);


%Compute the p-value associated to the statistic T. 
for trial=1:size(T,1)
    for interval=1:size(T,2)
      PVAL_MAT(trial,interval)=(1+sum(H0(trial,interval,:)>=T(trial,interval)))/(1+num_surs);
    end
end



 