function [data] = controlData(borderIm, ogIm)
borderIm = pushborderin(pushborderin(pushborderin(borderIm)));
data = double(getxy(borderIm));
data = [data; double(getcurv(data).')];
data = [data; double(getexpress(find(borderIm == 1).', ogIm))];
end