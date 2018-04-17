function dist = euclideanDist(v1, v2)
%euclideanDist calculates the euclidean distance
%   between the input vectors v1 and v2

dist = sqrt(sum((v2 - v1) .^ 2));

return

