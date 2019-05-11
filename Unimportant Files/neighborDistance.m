%Will return with list of points that are neighbors to the point in the
%image with a max distance search of max ie will check at most max distance
%away
function [data, found] = neighborDistance(imageData, point, target,  maxdistance, data, depth)
depth = depth + 1;
found = 0;
if depth > maxdistance
    found = 0;
    return;
end
length = size(imageData, 2);
y = mod(point, length);
if y == 0
    y = length;
end
x = ceil(point / length);

xx = x-1:x+1;
yy = y - 1:y+1;
change = [0 0 0 0];
if y - 1 < 1
    yy(yy < 1) = 1;
    change(1) = 1;
end
if x - 1 < 1
    xx(xx < 1) = 1;
    change(2) = 1;
end

if x + 1 > length
    xx(xx > length) = length;
    change(3) = 1;
end

if y + 1 > length
    yy(yy > length) = length;
    change(4) = 1;
end

imDat = imageData(yy, xx);
mid = round(size(imDat, 1)/2);
if change(1) == 1
    imDat(1:1-y+1, :) = 0;
end
if change(2) == 1
    imDat(:,1:1-x+1) = 0;
end
if change(3) == 1
    imDat(:,  mid -(x - length) + 1:(mid+1)) = 0;
end
if change(4)== 1
    imDat(mid -(y - length) + 1:(mid+1), :) = 0;
end

points = (find(imDat == 1)).';
if size(points, 2) ~= 0
    length2 = size(imDat, 1);
        y2 = mod(points, length2);
        y2(y2 == 0) = length2;
        realPoints = ((y2 - mid) + y)+ ((ceil(points/ length2) - mid) + x - 1)*length;
        realPoints(ismember(realPoints, data) == 1) = [];
    data = [realPoints data];
    for point2 = realPoints
        if point2 == target
            found = 1;
            return;
        end
        [data, found] = neighborDistance(imageData, point2, target, maxdistance, data, depth);
        if found == 1
            return;
        end
    end
end
end