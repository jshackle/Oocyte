%Finds the top longest continuous paths in the image and deletes the rest
%Max2 - distance allowed between points in the path
%Number - how many different paths to return ie 2 = top 2 paths returned
function [newMat] = makeCircular(imageData, max2, number)
points = find(imageData == 1);
neigh = cell(size(points, 1), 1);
lens = zeros(1, size(points, 1));
foundPoints = zeros(1, size(points, 1));

for ii = 1:size(points, 1)
    point = points(ii);
    if size(find(foundPoints == point), 2) == 0
    neighs = findNeighbors(imageData, point, max2);
    emptyPoints = find(foundPoints == 0);
    for kk = 1:size(neighs, 2)
        foundPoints(emptyPoints(kk)) = neighs(kk);
    end
    neigh{ii} =neighs;
    lens(ii) = size(neighs, 2);
    end
end
newMat = zeros(size(imageData, 1), size(imageData, 1));
for ii = 1:number
    ind = find(lens == max(lens));
    ind = ind(1);
    newMat(neigh{ind}) = 1;
    neigh(ind) = [];
    lens(ind) = [];
end