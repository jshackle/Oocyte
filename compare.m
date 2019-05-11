fname = "/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif";
info = imfinfo(fname);
%A = Tiff("/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif", 'r');
%imageData = read(A);

num_images = numel(info);
for kk = 100:num_images
    fname = "/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif";
info = imfinfo(fname);
    A = imread(fname, kk, 'Info', info);
    fname = ['TB/border_' int2str(kk) '.tif' ];
    info = imfinfo(fname);
    B = imread(fname, 'Info', info);
    imagesc(double(A) + double(1000*B));
    pause(0.1);
    disp(kk);
end