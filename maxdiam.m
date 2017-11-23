  function diam = maxdiam(K,DATA)

maxd = zeros(K,1);

for k = 1:K

  D= DATA(:,:,k);
  D(~any(D,2),:) = [];
  counter = size(D,1);
  for i = 1:(counter-1)
    for j = (i+1):counter  
      d = distance(D(i,:),D(j,:));
      
      if(d > maxd(k))
      maxd(k) = d;
      endif
  
    endfor
  endfor

endfor

diam = max(maxd);





end