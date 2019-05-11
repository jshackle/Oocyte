function [similar] = checkBoundary(prevBoundary, boundary)
count1 = size(find(prevBoundary == 1), 1);
count2 = size(find(boundary == 1), 1);
similar = (count1 - count2)^2 < 100^2;
end