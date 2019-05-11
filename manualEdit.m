for kk = 1:607
    fname = "/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif";
info = imfinfo(fname);
    A = imread(fname, kk, 'Info', info);
    fname = ['TB/border_' int2str(kk) '.tif' ];
    info = imfinfo(fname);
    B = imread(fname, 'Info', info);
    B(B == 255) = 1;
    B  = UIEdit2(B, A);
    pause
    B = slimCircle3(B);
    imwrite(B, ['Manual/' ['border_' int2str(kk)]], 'TIFF');
    close
end