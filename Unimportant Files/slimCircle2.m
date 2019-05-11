%idea find set of three connected points that have properties:
%essential for completeCircle
%one of two points on the same horizontal line that have said property
%Better than slimCircle however slightly riskier (could not work if no
%three pixels do not share the above properties)
function [imageData] = slimCircle2(imageData)
[found, pointHolder2] = testOne(imageData, 0, 512);
if found == 0
    [found, pointHolder2] = testOne(imageData, 512, 1024);
end
if found == 0
    [found, pointHolder2] = testTwo(imageData, 0, 512);
end
if found == 0
    [found, pointHolder2] = testTwo(imageData, 512, 1024);
end
if found == 1
point1 = [pointHolder2(1, 1) pointHolder2(1, 2)];
point2 = [pointHolder2(2, 1) pointHolder2(2, 2)];
point3 = [pointHolder2(3, 1) pointHolder2(3, 2)];
imageData(point2(1), point2(2)) = 0;
Goals = zeros(1024, 1024);
Goals(point3(1), point3(2)) = 1;
rute = ASTARPATH(point1(2), point1(1), 1-imageData, Goals, 1);
imageData = zeros(1024, 1024);
imageData(point2(1), point2(2)) = 1;
for kk = 1:size(rute, 1)
    imageData(rute(kk, 1), rute(kk,2)) = 1;
end
end
end

function [found, pointHolder2] = testOne(imageData, starting, ending)
length = size(imageData, 2);
y = starting;
pointHolder2 = zeros(9, 2);
found = 0;
while found == 0 && y < ending
    y = y + 1;
    count = 0;
    x = 0;
    pointHolder = zeros(3, 2);
    while x < 1024 && count <= 1
        x = x + 1;
        if imageData(y, x) == 1
            imageData(y, x) = 0;
            if ~isCompleteCircle(imageData)
                count = count + 1;
                pointHolder(count, 1) = y;
                pointHolder(count, 2) = x;
            end
            imageData(y,x) = 1;
        end
    end
    if count == 1
        for ii = 1:2
            if found == 0
                x2 = pointHolder(ii, 2);
                y2 = pointHolder(ii, 1);
                xx = x2-1:x2+1;
                yy = y2-1:y2+1;
                xx(xx < 1) = [];
                xx(xx > length) = [];
                yy(yy < 1) = [];
                yy(yy > length) = [];
                
                count2 = 0;
                pointHolder2 = zeros(9, 2);
                for y3 = yy
                    for x3 = xx
                        if imageData(y3, x3) == 1
                            imageData(y3, x3) = 0;
                            if ~isCompleteCircle(imageData)
                                count2 = count2 + 1;
                                pointHolder2(count2, 1) = y3;
                                pointHolder2(count2, 2) = x3;
                            end
                            imageData(y3, x3) = 1;
                        end
                    end
                end
                if count2 == 3 && (pointHolder2(1, 1) < pointHolder2(2, 1) && pointHolder2(2, 1) < pointHolder2(3, 1))
                    found = 1;
                end
            end
        end
    end
end
end

function [found, pointHolder2] = testTwo(imageData, starting, ending)
length = size(imageData, 2);
x = starting;
pointHolder2 = zeros(9, 2);
found = 0;
while found == 0 && x < ending
    x = x + 1;
    count = 0;
    y = 0;
    pointHolder = zeros(3, 2);
    while y < 1024 && count <= 1
        y = y + 1;
        if imageData(y, x) == 1
            imageData(y, x) = 0;
            if ~isCompleteCircle(imageData)
                count = count + 1;
                pointHolder(count, 1) = y;
                pointHolder(count, 2) = x;
            end
            imageData(y,x) = 1;
        end
    end
    if count == 1
        for ii = 1:2
            if found == 0
                x2 = pointHolder(ii, 2);
                y2 = pointHolder(ii, 1);
                xx = x2-1:x2+1;
                yy = y2-1:y2+1;
                xx(xx < 1) = [];
                xx(xx > length) = [];
                yy(yy < 1) = [];
                yy(yy > length) = [];
                
                count2 = 0;
                pointHolder2 = zeros(9, 2);
                for y3 = yy
                    for x3 = xx
                        if imageData(y3, x3) == 1
                            imageData(y3, x3) = 0;
                            if ~isCompleteCircle(imageData)
                                count2 = count2 + 1;
                                pointHolder2(count2, 1) = y3;
                                pointHolder2(count2, 2) = x3;
                            end
                            imageData(y3, x3) = 1;
                        end
                    end
                end
                if count2 == 3 && (pointHolder2(1, 2) < pointHolder2(2, 2) && pointHolder2(2, 2) < pointHolder2(3, 2))
                    found = 1;
                end
            end
        end
    end
end
end

