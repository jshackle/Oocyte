%Loops through the boundaries and images and creates a cell which contains matrices in which
%the first row represents the point of the border in the original boundary image
%the second and third rows represent the y and x values (wrt the bottom left corner) respectively
%the fourth row representing curvature
%the fifth row representing protein expression
fname = "/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif";
info = imfinfo(fname);

num_images = numel(info);
dataArray = cell(1, num_images);
for kk = 1:num_images
    fname = "/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif";
    info = imfinfo(fname);
    A = imread(fname, kk, 'Info', info);
    fname = ['TB/border_' int2str(kk) '.tif' ];
    info = imfinfo(fname);
    B = imread(fname, 'Info', info);
    B = double(B);
    B(B == 255) = 1;
    data = controlData(B, A);
    dataArray{kk} = data;
    disp(kk);
end
