%Will return with list of points that are neighbors to the point in the
%image with a max distance search of max ie will check at most max distance
%away
function [imageData] = findNeighborsHelper(imageData, point, range)
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

imageData(points) = 0;
    for point2 = points
        imageData = findNeighborsHelper(imageData, point2, range);
    end
end