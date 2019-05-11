%Should make the border one pixel thick
%Need to alter this alg so that we don't get suboptimal loops
%Two paths that both won't stop the circle
%Want one with smaller path
function [imageData] = slimCircle(imageData)
points = find(imageData == 1).';
points = points(randperm(length(points)));
for point = points
    imageData(point) = 0;
    if ~isCompleteCircle(imageData)
        imageData(point) = 1;
    end
end
end

    