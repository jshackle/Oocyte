function [imageh] = UIEdit(A, B)
fh = figure;
imageh = imshow(A, []);
% uicontrol('Parent',fh,'Style','pushbutton','String','paint','Callback',{@paintButtonCallback, imageh});
% bh = uicontrol('Parent',fh,'Style','pushbutton','String','line','Callback',{@lineButtonCallback, imageh});
% bh.Position(2) = 50;
% bh2 = uicontrol('Parent',fh,'Style','pushbutton','String','line2','Callback',{@line2ButtonCallback, imageh});
% bh2.Position(2) = 80;
% bh3 = uicontrol('Parent',fh,'Style','pushbutton','String','free','Callback',{@freeButtonCallback, imageh});
% bh3.Position(2) = 110;
set(fh, 'KeyPressFcn', {@freeButtonCallback, imageh});
% button callback function
% button callback function
function freeButtonCallback(~,~,imageh)
% take two points at a time
h = drawfreehand;
x = h.Position(:,1);
y = h.Position(:,2);
delete(h);

ind = sub2ind(size(imageh.CData),round(y),round(x));

% make the selected pixel white.
imageh.CData(ind) = 255;
% make sure the values do not go outside the image.
s = size(imageh.CData);
if ismember(1, x > s(2)) || ismember(1, y > s(1)) || ismember(1, y < 1)  || ismember(1, x < 1) 
    return
end
disp(isCompleteCircle(imageh.CData));
% make the selected pixel white.

end

end