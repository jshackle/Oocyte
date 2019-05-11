%Makes a straight matrix with a line going straight down the middle
%horizontally, verically, diagonally, and in an arc of a circle
%For orders 1-8, you get the different types
function [mat] = makeMat(order, length, thickness)
mid = round(length/2);
if order == 1
    mat = ones(length, length);
    mat = 0 - mat;
    for ii = 0:thickness
        mat(mid+ii, :) = 2/(ii +1);
        mat(mid-ii, :) = 2/(ii +1);
    end
elseif order == 2
    mat = ones(length, length);
    mat = 0 - mat;
    for ii = 0:thickness
        mat(:, mid + ii) = 2/(ii +1);
        mat(:, mid - ii) = 2/(ii +1);
    end
elseif order == 3
    mat = ones(length, length);
    mat = 0 - mat;
    for ii = 1:length
        for jj = 0:thickness
            mat(ii+jj, ii) = 2/(jj+1);
            mat(ii, ii+jj) = 2/(jj+1);
        end
    end
    mat = mat(1:length, 1:length);
elseif order == 4
    mat = ones(length, length);
    mat = 0 - mat;
    for ii = 1:length
        for jj = 0:thickness
            mat(ii+jj, ii) = 2/(jj+1);
            mat(ii, ii+jj) = 2/(jj+1);
        end
    end
    mat = mat(1:length, 1:length);
    mat = flip(mat, 2);
elseif order == 5 || order == 6 || order == 7 || order == 8
    radius = length - thickness;
    [q1, q2, q3, q4] = solveEquation(radius, length, 2);
    for  kk = 1:thickness
    [q1p, q2p, q3p, q4p] =  solveEquation(radius + kk, length, 1/(kk+1));
    q1 = q1 + q1p;
    q2 = q2 + q2p;
    q3 = q3 + q3p;
    q4 = q4 + q4p;
    [q1p, q2p, q3p, q4p] =  solveEquation(radius - kk, length, 1/(kk+1));
    q1 = q1 + q1p;
    q2 = q2 + q2p;
    q3 = q3 + q3p;
    q4 = q4 + q4p;
    end
    
    q1(q1 > 1) = 1;
    q2(q2 > 1) = 1;
    q3(q3 > 1) = 1;
    q4(q4 > 1) = 1;
    
    q1 = matrixFull(q1);
    q2 = matrixFull(q2);
    q3 = matrixFull(q3);
    q4 = matrixFull(q4);
    
    q1(q1 == 0) = -1;
    q2(q2 == 0) = -1;
    q3(q3 == 0) = -1;
    q4(q4 == 0) = -1;
    if order == 5
        mat = q1(1:length, 1:length);
    elseif order == 6
        mat = q2(1:length, 1:length);
    elseif order == 7
        mat = q3(1:length, 1:length);
    elseif order == 8
        mat = q4(1:length, 1:length);
    end
end
end

function [quad1, quad2, quad3, quad4] = solveEquation(radius, maxrad, value)
rad1 = maxrad + 1;
rad2 = maxrad + 2;
quad1 = zeros(rad1, rad1);
quad2 = zeros(rad1, rad1);
quad3 = zeros(rad1, rad1);
quad4 = zeros(rad1, rad1);
for x = 0:radius
    y = round((radius^2 - x^2)^.5);
    y = y + 1;
    x = x + 1;
        quad1(rad2 - y, x) = value;
        quad2(rad2 - y, rad2 -  x) = value;
        quad4(y, x) = value;
        quad3(y, rad2 - x) = value;
        quad1(rad2 - x,y) = value;
        quad2(rad2 - x, rad2 - y) = value;
        quad4(x, y) = value;
        quad3(x, rad2 - y) = value;
end
end