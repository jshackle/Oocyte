function [xandy] = getxy(imageData)
points = findpointsincircle(imageData);
length = size(imageData, 1);
y = mod(points, length);
y(y == 0) = length;
x = ceil(points / length);
y = 1024 - y + 1;
xandy = [points;y;x];
end
