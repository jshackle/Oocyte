%Attempt to use curvature of boundary to find where the boundary is and fix
%the borders. Error often occurs with high enough maxRadius

%Pretty obsolete function
%Checks black points near white points and places a circle of varying radii up to
%maxRadius to see if it matches the curvature of the circle sufficiently
function [newImage] = fixBoundaries(imageData, maxRadius)
length = size(imageData, 1);
neighTrack = cell(1, length*length/2);
neighTrack2 = containers.Map('KeyType', 'double', 'ValueType', 'any');
circsX = cell(1, maxRadius - 2);
circsY = cell(1, maxRadius - 2);
for radius = 3:maxRadius
    circ = solveEquation2(radius);
    circOnes = find(circ == 1);
    circsX{radius - 2}  = (ceil(circOnes.' / (2*radius + 1))) - radius - 1;
    circY = mod(circOnes.', 2*radius + 1);
    circY(circY == 0) = 2*radius + 1;
    circY = circY - radius - 1;
    circsY{radius - 2} = circY; 
end
bPoints = find(imageData == 0);
counter = 0;
disp(size(bPoints, 1));
for point = bPoints.'
    if mod(counter, 10000) == 0
        disp(counter);
    end
    counter = counter + 1;
    y = mod(point, length);
    if y == 0
        y = length;
    end
    x = ceil(point / length);
    aa = y-1:y+1;
    bb = x-1:x+1;
    aa(aa < 1) = [];
    bb(bb< 1) = [];
    aa(aa > length) = [];
    bb(bb > length) = [];
    imDat = imageData(aa, bb);
    if size(find(imDat == 1),1) ~= 0
        [confid, neigh, neighTrack, neighTrack2]  = directionGuess(imageData, x, y, bb, aa, circsX, circsY,  neighTrack, neighTrack2);
        if confid >= 4
            imageData(y, x) = 1;
            if neigh ~= 0
             ind1 = neighTrack2(neigh);
            neighTrack2((y)+ (x - 1)*length) = ind1;
            neighTrack{ind1} = [neighTrack{ind1} (y)+ (x - 1)*length];
            end
        end
    end
end
newImage = imageData;