fname = "/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif";
info = imfinfo(fname);
%A = Tiff("/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif", 'r');
%imageData = read(A);

num_images = numel(info);
for kk = 85:num_images
    tic;
    A = imread(fname, kk, 'Info', info);
    A = controlCenter(A);
    if kk ~= 1
        if checkBoundary(A, pastData)
            pastData = A;
            imwrite(A, ['Pics7/' ['border_' int2str(kk)]], 'TIFF');
        else
            imwrite(A, ['Pics8/' ['border_' int2str(kk)]], 'TIFF');
        end
    else
    imwrite(A, ['Pics7/' ['border_' int2str(kk)]], 'TIFF');
    pastData = A;
    end
    disp(kk);
    toc;
end