%Helper function for makeMat
function [newMat]  = matrixFull(mat)
length = size(mat, 1);
newMat = mat;
points = find(newMat == 0);
for point = points.'
    y = mod(point, length);
    if y == 0
        y = length;
    end
    x = ceil(point / length);
    try
    if newMat(y, x+1) > 0 && newMat(y, x-1) > 0 && newMat(y - 1, x) > 0 && newMat(y + 1, x) > 0
        newMat(y, x) = mean([newMat(y, x+1) newMat(y, x-1) newMat(y - 1, x) newMat(y+1, x)]);
    end
    catch 
    end
end