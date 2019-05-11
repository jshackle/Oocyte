%Should make the border one pixel thick
%Imfills at center of circle (512, 512) and keeps all points the new points
%generated touch
function [newData] = slimCircle3(imageData)
length = size(imageData, 1);
newData = zeros(length, length);
imageData(512, 512) = 0;
ogpoints = find(imageData == 1).';
imageData = logical(imageData);
imageData = imfill(imageData, [512, 512]);
imageData = double(imageData);
imageData(ogpoints) = 2;
for point = ogpoints
     y = mod(point, length);
    if y == 0
        y = length;
    end
    x = ceil(point / length);
    xx = x-1:x+1;
    yy = y-1:y+1;
    xx(xx < 1) = [];
    yy(yy < 1) = [];
    xx(xx> length) = [];
    yy(yy>length) = [];
    imDat = imageData(yy, xx);
    if size(find(imDat == 1), 1) >= 1
        newData(point) = 1;
    end
end
end