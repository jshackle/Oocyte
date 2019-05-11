%Attempt to make a master function that completes process an image from
%original picture to final result
function[imageData] = controlCenter(imageData, pastData)
cop = imageData;
%Rough algorithms
imageData = edge(imageData, 'Sobel');
imageData = double(imageData);
imageData = imageData + pastData;
imageData = connectPoints3(imageData, 15);
imageData = borderFinding(imageData, 61, 5, 1, -70);
imageData = connectPoints3(imageData, 7);
imageData = makeCircular(imageData, 5, 2);
imageData = connectPoints3(imageData, 4);
imageData = densityAlg(imageData, 8, 10);
imageData = makeCircular(imageData, 1, 1);
if isCompleteCircle(imageData)
    for ii = 1:3
    imageData = slimCircle4(imageData);
    imageData = connectPoints3(imageData, ii+2);
    imageData = slimCircle3(imageData);
    imageData = connectPoints3(imageData, ii+2);
    end
    imageData = slimCircle3(imageData);
    return;
end
%Gentle algorithms, easier parameters
%Goes to this one if image processing is too rough in first attempt
imageData = cop;
imageData = edge(imageData, 'Sobel', 0.0002);
imageData = double(imageData);
imageData = imageData + pastData;
imageData = borderFinding(imageData, 61, 5, 1, -10);
imageData = makeCircular(imageData, 5, 2);
imageData = connectPoints3(imageData, 4);
imageData = densityAlg(imageData, 8, 10);
imageData = makeCircular(imageData, 1, 1);
if isCompleteCircle(imageData)
    for ii = 1:3
    imageData = slimCircle4(imageData);
    imageData = connectPoints3(imageData, ii+2);
    imageData = slimCircle3(imageData);
    imageData = connectPoints3(imageData, ii+2);
    end
    imageData = slimCircle3(imageData);
    return;
end
end