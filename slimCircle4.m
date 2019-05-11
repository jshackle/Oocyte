%Should make the border one pixel thick
%Imfill at top left corner, keeps all points the new points created by
%imfill touch
function [newData] = slimCircle4(imageData)
length = size(imageData, 1);
newData = zeros(length, length);
imageData(1) = 0;
ogpoints = find(imageData == 1).';
imageData = logical(imageData);
imageData = imfill(imageData, [1 1]);
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
    if size(find(imageData(yy, xx) == 1), 1) >= 1
        newData(point) = 1;
    end
end
end
    