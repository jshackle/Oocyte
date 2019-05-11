%Meaning of this function is to connect points that are close together and
%separated by black pixels
%dist - distance between points
%Connects all points that are separated by a distance less than dist
function [imageData] = connectPoints3(imageData, dist)
points = (find(imageData == 1)).';
length = size(imageData, 1);
%Loop through points
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
    %Points around iterated point
    points2 = reshape(bsxfun(@plus,yy,((xx-1)*length).'),1,[]);
    points2(points2 == point) = [];
    %Loop through points around the point
    for point2 = points2
        %Connect points if it's not a black point
        if imageData(point2) == 1
            y3 = mod(point2, length);
            if y3 == 0
                y3 = length;
            end
            x3 = ceil(point2 / length);
                imageData = shortpath(y, x, y3, x3, imageData);
        end
    end
end
end