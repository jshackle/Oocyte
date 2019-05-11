function [L,R,k] = curvature(X)
% Radius of curvature and curvature vector for 2D or 3D curve
%  [L,R,Kappa] = curvature(X)
%   X:   2 or 3 column array of x, y (and possibly z) coordiates
%   L:   Cumulative arc length
%   R:   Radius of curvature
%   k:   Curvature vector
% Taken from https://www.mathworks.com/matlabcentral/fileexchange/69452-curvature-of-a-2d-or-3d-curve
  N = size(X,1);
  dims = size(X,2);
  if dims == 2
    X = [X,zeros(N,1)];  % Do all calculations in 3D
  end
  L = zeros(N,1);
  R = NaN(N,1);
  k = NaN(N,3);
  for ii = 3:N-2
    [R(ii),~,k(ii,:)] = circumcenter2(X(ii,:)',X(ii-1,:)',X(ii+1,:)');
    L(ii) = L(ii-1)+norm(X(ii,:)-X(ii-1,:));
  end
  ii = N;
  L(ii) = L(ii-1)+norm(X(ii,:)-X(ii-1,:));
  if dims == 2
    k = k(:,1:2);
  end
end