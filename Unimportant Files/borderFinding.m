%Creates matrices that look for borders along horizontal, vertical, and the
%two diagonal lines. 
%Length - size of sides of square matrices that are used to find the
%borders
%Thickness - thickness of the border in the matrix
%Step - How many points to jump when looping through image
%Factor - used to determine which values stay and which go - low negative
%number means a lot stay, high negative number means a lot go
%Params 61, 5, 1,-70  give good results
%Params 11, 2, 1, 10  good results
function [newImage] = borderFinding(imageData, length, thickness, step, factor)
length2 = size(imageData, 1);
newImage = zeros(length2, length2);
numMats = 8;
mats = cell(1, numMats);
%Create matrices
 for ii = 1:numMats
     mats{ii} = makeMat(ii, length, thickness);
 end
 %Loop through imageData
for xx  = 1:step:length2 - length
    for yy = 1:step:length2 - length
        aa = yy:yy + length - 1;
        bb = xx:xx+length - 1;
        imDat = imageData(aa, bb);
        nonzeros = find(imDat ~= 0);
        %If image clump contains white pixels
        if size(nonzeros, 1) ~= 0
        %Values of integer representation of how well the horiz, vert...
        %matrx fits over the image clump
        bests = zeros(1, numMats);
        for ii = 1:numMats
        bests(ii) = mats{ii}(nonzeros).'*imDat(nonzeros);
        end
        best = max(bests);
        %If the best integer value is better than a certain number
        %determined by factor parameter, then keep the image clump
        if best > length*length/factor
            newImage(aa, bb) = imageData(aa, bb);
        end
        end
    end
end
end
