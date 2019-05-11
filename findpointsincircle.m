function [points] = findpointsincircle(borderIm)
length = size(borderIm, 2);
points = find(borderIm == 1).';
y3 = mod(points, length);
y3(y3 == 0) = length;
x3 = ceil(points / length);
y3 = 1024 - y3 + 1;
%find highest y
maxy = max(y3);
ind = find(y3 == maxy);
xx = x3(ind);
startx = round(median(xx));
maxy  = 1024 - maxy + 1;
startpoint = maxy + (startx-1)*1024;

xx = startx - 1;
yy = maxy - 1:maxy + 1;
points2 = reshape(bsxfun(@plus,yy,((xx-1)*length).'),1,[]);
points2(borderIm(points2) == 0) = [];
point2a = points2;

xx = startx + 1;
yy = maxy - 1:maxy + 1;
points2 = reshape(bsxfun(@plus,yy,((xx-1)*length).'),1,[]);
points2(borderIm(points2) == 0) = [];
point2b = points2;

borderIm(startpoint) = 0;

points = findNeighbors2(borderIm, point2a, 1, []);
points = [startpoint points];

