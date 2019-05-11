%Used with fixBoundaries
%Not sure what it does, pretty obsolete
function [maxConfidence, returnNeigh, neighTrack, neighTrack2] = directionGuess(imageData, x, y, xxs, yys, circsX, circsY,  neighTrack, neighTrack2)
length = size(imageData, 1);
for xs = xxs
    for ys = yys
        if imageData(ys, xs) == 1
            realPoint = (ys)+ (xs - 1)*length;
            if ~isKey(neighTrack2, realPoint)
                neighs = findNeighbors(imageData, realPoint, 1, []);
                returnNeigh = 0;
                numNeighs = size(neighs, 2);
                if numNeighs > 20
                    returnNeigh = neighs(1);
                    space1 = find(cellfun('isempty', neighTrack));
                    space1 = space1(1);
                    for ii = 1:numNeighs
                        neighTrack2(neighs(ii)) = space1;
                    end
                    neighTrack{space1} = neighs;
                end
            else
                neighs = neighTrack{neighTrack2(realPoint)};
                returnNeigh = neighs(1);
            end
            maxConfidence = 0;
            neighData = zeros(1024, 1024);
            neighData(neighs) = 1;
            for indexx = 1:size(circsX, 2)
                confidence = 0;
                radius = indexx + 2;
                circY = circsY{indexx};
                circX = circsX{indexx};
                centerx = round(x + radius*((length/2 - x)/(((length/2 - x)^2 + (length/2 - y)^2)^.5)));
                centery = round(y + radius*((length/2 - y)/(((length/2 - x)^2 + (length/2 - y)^2)^.5)));
                circX = circX + centerx;
                circY = circY + centery;
                if centerx + radius > length || centery + radius > length || centery - radius < 1 || centerx - radius < 1
                    circY(circY > length) = 0;
                    circY(circY < 1) = 0;
                    circX(circX > length) = 0;
                    circX(circX < 1) = 0;
                    f1 = find(circX == 0);
                    circX(f1) = [];
                    circY(f1) = [];
                    f1 = find(circY == 0);
                    circX(f1) = [];
                    circY(f1) = [];
                end
                 for ii = 1:size(circX, 2)
                    if neighData(circY(ii), circX(ii)) == 1
                        confidence = confidence + 1/((x - circX(ii))^2 + (y-circY(ii))^2)^.5;
                    end
                end
                if confidence > maxConfidence
                    maxConfidence = confidence;
                end
            end
        end
    end
end
end