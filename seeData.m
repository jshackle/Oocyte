%This function kind of assumes that dataArray from masterData is saved in your workspace
c = zeros(4000, size(dataArray, 2));
for kk = 1:size(dataArray, 2)
a = dataArray{kk};
b = a(4, :).';
% b = abs(b.*70);
% c = b;
% for ii = 1:4
% c = [c b];
% end
% d = a(5, :).';
% for ii = 1:5
% c = [c d];
% end
% imagesc(c);
% pause(.1);
f = size(b, 1);
if f > 4000
    f = 4000;
end
c(1:f, kk) = b(1:f);
end
imagesc(c);
