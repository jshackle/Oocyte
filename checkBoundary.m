%Checks two boundary images and returns true if they are similar (with regards to number of pixels)
function [similar] = checkBoundary(prevBoundary, boundary)
count1 = size(find(prevBoundary == 1), 1);
count2 = size(find(boundary == 1), 1);
similar = (count1 - count2)^2 < 100^2;
end
