function [newImage] = avgFinding(imageData, sizer)
%Really not a relevant algorithm, but I don't want to delete it
%This algorithm basically computes the average around each white pixel and
%gets rid of the pixels with too many and too few pixels around it (what
%percent can be modified). The reason is too find pixels that are near the
%edge with black on one side and some white on the other.
Kx = ones(sizer, sizer);
length = size(imageData, 1);
newImage = zeros(length, length);
points = find(imageData == 1);
averages = cell(1, size(points, 1));
counter = 0;
for point = points.'
    counter = counter + 1;
    y = mod(point, length);
    if y == 0
        y = length;
    end
    x = ceil(point / length);
    aa = x-floor(sizer/2):x+floor(sizer/2);
    aa(aa<1) = 1;
    aa(aa>1024) = 1024;
    bb = y-floor(sizer/2):y+floor(sizer/2);
    bb(bb<1) = 1;
    bb(bb>1024) = 1024;
    matrixy = double(imageData(aa, bb));
    Ox = Kx(1:sizer^2)*matrixy(1:sizer^2).';
    averages{counter} = [Ox, y, x];
end
%This is where we select what points we want to keep in the new image
for ll = 1:size(points, 1)
    marr = averages{ll};
    if 0<= marr(1) && marr(1) < round((sizer^2)/5)
        newImage(marr(2), marr(3)) = 1;
    end
end
end