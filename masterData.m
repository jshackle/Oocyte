fname = "/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif";
info = imfinfo(fname);

num_images = numel(info);
dataArray = cell(1, num_images);
for kk = 1:num_images
    tic;
    fname = "/home/john/Documents/BiophysicsUROP2/MAX_Actin_All.tif";
    info = imfinfo(fname);
    A = imread(fname, kk, 'Info', info);
    fname = ['TB/border_' int2str(kk) '.tif' ];
    info = imfinfo(fname);
    B = imread(fname, 'Info', info);
    B = double(B);
    B(B == 255) = 1;
    data = controlData(B, A);
    %writematrix(data, ['FinalData/' ['data_' int2str(kk)] ]);
    dataArray{kk} = data;
    disp(kk);
    toc;
end
