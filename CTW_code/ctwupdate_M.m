function  [eta,beta_M,contT_M] = ctwupdate_M( eta, index, xt,alpha,beta_M,contT_M, j_index)
% countTree:  countTree(a+1,:) is the tree for the count of symbol a a=0,...,M
% betaTree:   betaTree(i(s) ) =  Pe^s / \prod_{b=0}^{M} Pw^{bs}(x^{t})
% eta = [ p(X_t = 0|.) / p(X_t = M|.), ..., p(X_t = M-1|.) / p(X_t = M|.)

% calculate eta and update beta a, b
% xt is the current data

%size of the alphbet
Nx = length(eta)+1;

pw = [eta 1];
pw = pw/sum(pw);  % pw(1) pw(2) .. pw(M+1)

%pe = (countTree(:,index)+0.5)'/(sum(countTree(:,index))+Nx/2);
pe =(contT_M(j_index,:)+0.5) /(sum(contT_M(j_index,:))+Nx/2);
%temp = (betaTree(index));
temp= beta_M(j_index);

if (temp < 1000)
    eta = (alpha*temp * pe(1:Nx-1) + (1-alpha)*pw(1:Nx-1) ) / ( alpha*temp * pe(Nx) + (1-alpha)*pw(Nx)) ;
else
    eta = (alpha*pe(1:Nx-1) + (1-alpha)*pw(1:Nx-1)/temp ) / ( alpha*pe(Nx) + (1-alpha)*pw(Nx)/temp) ;
end


%countTree(xt+1,index) = countTree(xt+1,index) + 1;
%betaTree(index) = betaTree(index) * pe(xt+1)/pw(xt+1);

beta_M(j_index)=beta_M(j_index) * pe(xt+1)/pw(xt+1);
contT_M(j_index,xt+1)=contT_M(j_index,xt+1)+1;