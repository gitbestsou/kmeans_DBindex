function dist = disclust(cluster1,cluster2)

dist = distance(cluster1(1,:),cluster2(1,:));

for i = 1:rows(cluster1)
  for j = 1:rows(cluster2)
    ds = distance(cluster1(i,:),cluster2(j,:));
    
    if(ds<dist)
    dist = ds;
    endif
    
  endfor
endfor

end