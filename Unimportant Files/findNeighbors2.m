function [data] = findNeighbors2(imageData, point, range, data)
length = size(imageData, 2);
y = mod(point, length);
if y == 0
    y = length;
end
x = ceil(point / length);

xx = x-range:x+range;
yy = y - range:y+range;
xx(xx < 1) = [];
yy(yy < 1) = [];
xx(xx> length) = [];
yy(yy>length) = [];
points = reshape(bsxfun(@plus,yy,((xx-1)*length).'),1,[]);
points(points == point) = [];
points(imageData(points) == 0) = [];
points(ismember(points, data) == 1) = [];
data = [data points];
    for point2 = points
        data = findNeighbors2(imageData, point2, range, data);
    end
end
