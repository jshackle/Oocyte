fname = 'SampleData/sobel';
info = imfinfo(fname);
A = imread(fname, 'Info', info);
tic
e = borderFinding(A, 8, 10);
toc
subplot(2, 1, 1);
imagesc(e);
colormap gray
axis square
subplot(2, 1, 2);
imagesc(A);
colormap gray
axis square