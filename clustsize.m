function size = clustsize(clusterPoints,clusterCentroid)

#{
size = 0;
for i = 1:rows(clusterPoints)
  s = distance(clusterPoints(i,:),clusterCentroid);  
  if(s>size)
    size = s;
  endif    
endfor
end
#}

sumsize = 0;
for i = 1:rows(clusterPoints)
  s = (distance(clusterPoints(i,:),clusterCentroid))^2;
sumsize = sumsize + s;
endfor
%rows(clusterPoints)
sumsize = sumsize/rows(clusterPoints);
size = sqrt(sumsize);