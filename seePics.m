for kk = 1:607
    fname = ['Pics9/border_' int2str(kk)  '.tif'];
    info = imfinfo(fname);
    A = imread(fname, 'Info', info);
    A = double(A);
    A(A == 255) = 1;
    imshow(A, []);
    disp(kk);
end