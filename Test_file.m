clc
clear all;


%time series length
L=250;


%%%%%SIMULATED TIME SERIES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PARAMETERS
%delay
delay=5;
%binary noise 
epsilon=0.1;
%A)Dependent time series
NODE_1_MAT(1,:)=rand(1,L)<0.5;
NODE_2_MAT(1,:)=rand(1,L)<0.5;
NODE_2_MAT(1,delay+1:end)=NODE_1_MAT(1,1:end-delay)+(rand(1,L-delay)<epsilon);

%B)Independent time series%
%MAT_node_2=rand(1,L)<0.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%CTW PARAMETERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Alphabet
N=2;
%Memory
M=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%STATISTICAL PARAMETERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%interval size
interval_width=L;
interval_step=1;
%number of delays
num_delays=10;
delay_step=1;
%number of surrogates
num_surs=20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A)  DIRECTION X->Y, DI(X->Y)%%%%%%%
% 
%DI COMPUTATION%%%%%%%%%%%%%%%%%%%%%%
[DI_ORIGINAL_MAT, DI_SURROGATES_MAT]=DI_computation_per_pair(NODE_1_MAT,NODE_2_MAT,N,M,interval_width,interval_step,num_delays,delay_step,num_surs);


%DI TESTING%%%%%%%%%%%%%%%%%%%%
[PVAL_MAT,DELAY_MAT,T, H0]= DI_significance_test(DI_ORIGINAL_MAT, DI_SURROGATES_MAT, delay_step,num_surs);

%B)  DIRECTION Y->X, DI(X->Y)%%%%%%% DI(Y>X)%%%%%%%

% %1)DI COMPUTATION%%%%%%%%%%%%%%%%%%%%%%
% [DI_ORIGINAL_MAT, DI_SURROGATES_MAT]=DI_computation_per_pair(NODE_2_MAT,NODE_1_MAT,N,M,interval_width,interval_step,num_delays,delay_step,num_surs);
% 
% 
% %DI TESTING%%%%%%%%%%%%%%%%%%%%
% [PVAL_MAT,DELAY_MAT,T, H0]= DI_significance_test(DI_ORIGINAL_MAT, DI_SURROGATES_MAT, delay_step,num_surs);