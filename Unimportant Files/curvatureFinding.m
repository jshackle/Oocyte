%Algorithm that finds the boundary based on the accurateness of part of a
%circle to parts of the image
%Obsolete function
function [newImage] = curvatureFinding(imageData, radius, thickness)
length = size(imageData, 1);
newImage = zeros(length, length);
points = find(imageData == 1);
    radmax = radius + thickness;
    [q1, q2, q3, q4] = solveEquation(radius, radmax, 2);
    for  kk = 1:thickness
    [q1p, q2p, q3p, q4p] =  solveEquation(radius + kk, radmax, 1/(kk+1));
    q1 = q1 + q1p;
    q2 = q2 + q2p;
    q3 = q3 + q3p;
    q4 = q4 + q4p;
    [q1p, q2p, q3p, q4p] =  solveEquation(radius - kk, radmax, 1/(kk+1));
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
    
    q12 = q1;
    q22 = q2;
    q32 = q3;
    q42 = q4;
    
    q12(q12 > 0) = 1;
    q22(q22 > 0) = 1;
    q32(q32 > 0) = 1;
    q42(q42 > 0) = 1;
    
    q1(q1 == 0) = -1;
    q2(q2 == 0) = -1;
    q3(q3 == 0) = -1;
    q4(q4 == 0) = -1;
    
for point = points.'
    
    %Figure out x and y value from point value
    y = mod(point, length);
    if y == 0
        y = length;
    end
    x = ceil(point / length);
    distx = length/2 - x;
    disty = length/2 - y;
    centerx = round(x + radius*(distx/((distx^2 + disty^2)^.5)));
    centery = round(y + radius*(disty/((distx^2 + disty^2)^.5)));
    
    data1x = centerx+radmax:-1:centerx;
    data1y = centery - radmax:centery;
    data2x = centerx - radmax:centerx;
    data2y = data1y;
    data3x = data2x;
    data3y = centery:centery+radmax;
    data4x = data1x;
    data4y = data3y;
    
    matrix1 = imageData(data1y, data1x);
    matrix2 = imageData(data2y, data2x);
    matrix3 = imageData(data3y, data3x);
    matrix4 = imageData(data4y, data4x);
    
    total1 = q1(1:size(q1, 2)^2)*matrix1(1:size(matrix1, 2)^2).';
    total2 = q2(1:size(q2, 2)^2)*matrix2(1:size(matrix2, 2)^2).';
    total3 = q3(1:size(q3, 2)^2)*matrix3(1:size(matrix3, 2)^2).';
    total4 = q4(1:size(q4, 2)^2)*matrix4(1:size(matrix4, 2)^2).';
    
    sizes = [total1 total2 total3 total4];
    maxi = max(sizes);
    if maxi > round((2*pi*radius)/8)
        quad = find(sizes == maxi);
        quad = quad(1);
        if quad == 1
            newImage(data1y, data1x) = q12(:, size(q12, 2):-1:1);
        elseif quad == 2
            newImage(data2y, data2x) = q22;
        elseif quad == 3
            newImage(data3y, data3x) = q32;
        elseif quad == 4
            newImage(data4y, data4x) = q42(:, size(q12, 2):-1:1);
        end
    end
end