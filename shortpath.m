% Deniz KUMLU
% find the shortest path between two dots
% finding the shortest path between two dots
% to use try to understand how it works
% open image1=zeros(480,720)
% x = 100; y = 120; x1 = 160; y1 = 168
% and run img = shortpath(x,y,x1,y1,image1) this
function img = shortpath(x,y,x1,y1,image1)
if x > x1 && y > y1  % if this situation is true, l switch the coordinates
    k = x1;
    x1 = x;
    x = k;
    l = y1;
    y1 = y;
    y = l;    
end 
image1(x,y) = 1;
image1(x1,y1) = 1;
if abs(x-x1) >= abs(y-y1) % taking absolute of difference
rad = atan((y1-y)/(x1-x));
for i = 1:(x1-x)
    col = round(tan(rad)*i);
    image1(i+x,y+col) = 1;
end
else
rad = atan((x1-x)/(y1-y));
    for i = 1:(y1-y)
        row = round(tan(rad)*i);
        image1(x+row,i+y) = 1;
    end
    
end
if  x < x1 && y > y1     % this condition does not contain others and it gives problem when l draw this
    rad = atan((x1-x)/(y1-y)); % So l add this condition, and l gave every situation and it finds the shortest path
    for i = 1:(y-y1)
        row = round(tan(rad)*i);
        image1(x1+row,i+y1) = 1;
    end
elseif x == x1 && y > y1 % this is for straight line
    image1(x,y1:y) = 1;
elseif x > x1 && y == y1 % this is for straight line
    image1(x1:x,y) = 1;
end
    img = image1;
end    