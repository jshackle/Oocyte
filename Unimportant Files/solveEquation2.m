function [mat] = solveEquation2(radius)
maxrad = radius;
value = 1;
rad1 = maxrad + 1;
rad2 = maxrad + 2;
quad1 = zeros(rad1, rad1);
quad2 = zeros(rad1, rad1);
quad3 = zeros(rad1, rad1);
quad4 = zeros(rad1, rad1);
for x = [0:radius]
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
mat = [quad2 quad1; quad3 quad4];
mat(radius, :) = [];
mat(:, radius) = [];
end
