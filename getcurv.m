function [curv] = getcurv(data)
data = data(2:3, :).';
data = flip(data, 2);
%data = data - 512;
curv = LineCurvature2D(data);
end