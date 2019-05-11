%Finds if the circle has a complete circumference
function [isComplete] = isCompleteCircle(imDat)
imDat(512, 512) = 0;
imDat(1) = 0;
imDat = logical(imDat);
imDat = imfill(imDat, [512 512]);

if imDat(1) == 1
    isComplete= (0~=0);
else
    isComplete = (0==0);
end
end

