%Meaning of this function is to connect points that are close together and
%separated by black pixels
%dist - distance between points
%smalls - length of shortest path between the two points if they are on the
%same path
%Different than connectPoints3 as it takes into consideration that distance
%between the two points to connect on the path. It is more selective than
%connectPoints3, however, it is a lot lot lot slower
function [imageData] = connectPoints2(imageData, dist, smalls)
points = (find(imageData == 1)).';
length = size(imageData, 1);
for point = points
    y = mod(point, length);
    if y == 0
        y = length;
    end
    x = ceil(point / length);
    xx = x-dist:x+dist;
    yy = y-dist:y+dist;
    xx(xx < 1) = [];
    yy(yy < 1) = [];
    xx(xx> length) = [];
    yy(yy>length) = [];
    points2 = reshape(bsxfun(@plus,yy,((xx-1)*length).'),1,[]);
    points2(points2 == point) = [];
    for point2 = points2
        if imageData(point2) == 1
            y3 = mod(point2, length);
            if y3 == 0
                y3 = length;
            end
            x3 = ceil(point2 / length);
            [data, found] = neighborDistance(imageData, y + (x-1)*length, y3+(x3-1)*length,[], smalls, 0);
            if found == 0
                imageData = shortpath(y, x, y3, x3, imageData);
            end
        end
    end
end
end