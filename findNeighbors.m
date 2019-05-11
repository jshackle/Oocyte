%Will return with list of points that are neighbors to the point in the
%image with a max distance search of max ie will check at most max distance
%away
function [data] = findNeighbors(imageData, point, range)
Data2 = findNeighborsHelper(imageData, point, range);
data = find(Data2 == imageData == 0).';
end
