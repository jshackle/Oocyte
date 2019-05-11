%Attempt to make a master function that completes process an image from
%original picture to final result
function[imageData] = testCenter(imageData)
imageData = edge(imageData, 'Sobel', 0.00025);
imageData = double(imageData);
counter = 3;
while counter < 5
    imageData = connectPoints3(imageData, counter);
    counter = counter + 1;
end
counter = 2;
while ~isCompleteCircle(imageData)
    imageData = connectPoints3(imageData, counter);
    counter = counter + 1;
end
for ii = 1:3
    imageData = slimCircle4(imageData);
    imageData = connectPoints3(imageData, ii+2);
    imageData = slimCircle3(imageData);
    imageData = connectPoints3(imageData, ii+2);
end
imageData = slimCircle3(imageData);
return;
end

