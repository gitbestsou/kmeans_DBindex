function [d] = distance(x,y)
d = sqrt(sum((x-y).^2)); % Eucledian Distance
%d = sum(abs(x-y)); % Manhattan Distance
end