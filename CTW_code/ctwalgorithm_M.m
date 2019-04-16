
% DESCRIPTION: Function CTWAlgorithm outputs the universal sequential probability
% assignments given by CTW method.

function [Px_record ]= ctwalgorithm_M(x,Nx,D,Temps)
%function Px_record = ctwalgorithm(x,Nx,D)
if size(x,1) ~= 1 
    error('The input vector must be a colum vector!');
end

n=length(x);
%countTree = zeros(Nx, (Nx^(D+1) - 1) / (Nx-1)) ;
%betaTree = ones(1,(Nx^(D+1) - 1 )/ (Nx-1))  ;
Px_record = zeros(Nx,n-D);
indexweight = Nx.^[0:D-1];
offset = (Nx^(D) - 1) / (Nx-1) + 1;
%%%%
index_M=1;
contT_M=zeros(1,Nx);
beta_M=1;
%%%%%%%%%
for i=D+1:n,
    context = x(i-D:i-1);
    leafindex = context*indexweight'+offset; 
    xt = x(i);
    
    %%% si no existeix cami el creem
    if index_M ~= leafindex;
        index_M=[index_M,leafindex];
        beta_M=[beta_M,1];
        contT_M=[contT_M;zeros(1,Nx)];
        j_index=size(index_M,2);
    else
        j_index=find(index_M == leafindex);
    end
    %eta = (countTree(1:Nx-1,leafindex)'+0.5)/(countTree(Nx,leafindex)+0.5);
    eta = ( contT_M(j_index,1:Nx-1)   +0.5)/(contT_M (j_index,Nx)+0.5);
    % update the leaf
    %countTree(xt+1,leafindex) = countTree(xt+1,leafindex) + 1;  
    contT_M(j_index,xt+1)=contT_M(j_index,xt+1)+1;
    node =floor((leafindex+Nx-2)/Nx);
   
    %%% si no existeix cami el creem
    if index_M ~= node;
        index_M=[index_M,node];
        beta_M=[beta_M,1];
        contT_M=[contT_M;zeros(1,Nx)];
        j_index=size(index_M,2);
    else
        j_index=find(index_M == node);
    end
 
    %tic 
    %tic;
    while ( node ~=0)
        [eta,beta_M,contT_M] = ctwupdate_M(eta, node, xt,1/2,beta_M,contT_M, j_index) ;
        node =floor((node+Nx-2)/Nx); 
        %%% si no existeix cami el creem
        if index_M ~= node;
            index_M=[index_M,node];
            beta_M=[beta_M,1];
            contT_M=[contT_M;zeros(1,Nx)];
            j_index=size(index_M,2);
        else
            j_index=find(index_M == node);
        end       
    end
    
    
    
    %Temps(D,i)=toc;
    eta_sum = sum(eta)+1;
    Px_record(:,i-D) = [eta 1]'/eta_sum ;
end
%size(beta_M)