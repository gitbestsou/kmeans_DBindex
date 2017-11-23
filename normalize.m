function [data] = normalize(data)


for j = 1:columns(data)
  maximum(j) = max(data(:,j));
  minimum(j) = min(data(:,j));
endfor
for j = 1:columns(data)
  for i = 1:rows(data)
    data(i,j) = (data(i,j)-minimum(j))/(maximum(j)-minimum(j));
  endfor
endfor

end