%Pushes border inwards
function [imageData] = pushborderin(imageData)
length = size(imageData, 1);
ogpoints = find(imageData == 1).';
imageData = logical(imageData);
imageData = imfill(imageData, [512, 512]);
imageData = double(imageData);
imageData(ogpoints) = 2;
keeppoints = zeros(1, 10000);
counter = 0;
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
    points = reshape(bsxfun(@plus,yy,((xx-1)*length).'),1,[]);
    add = zeros(1, 9);
    counter2 = 0;
    for point2 = points
        if imageData(point2) == 1
            counter2 = counter2 + 1;
            add(counter2) = point2;
        end
    end
    for pointers = add
        counter = counter + 1;
        keeppoints(counter) = pointers;
    end
end
imageData = zeros(length, length);
keeppoints(keeppoints == 0) = [];
for point = keeppoints
    imageData(point) = 1;
end
%imageData = slimCircle3(imageData);
end
