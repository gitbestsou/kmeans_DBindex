function r = Rcal(k,K,clusterSize,clusterDistances)

Rr = zeros(K,1);

for i = 1:K
  if(i!=k)
    Rr(i,1) = (clusterSize(i,1)+clusterSize(k,1))/clusterDistances(i,k);
  endif
endfor

r = max(Rr);

end