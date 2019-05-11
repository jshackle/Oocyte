function [data] = checkNeighs(neighs, point, data)
length = 1024;
y = mod(point, length);
if y == 0
    y = length;
end
x = ceil(point / length);
xx = x-1:x+1;
yy = y-1:y+1;
xx(xx < 1) = [];
xx(xx > length) = [];
yy(yy < 1) = [];
yy(yy > length) = [];

possibles = reshape(bsxfun(@plus,yy,((xx-1)*length).'),1,[]);
for point2 = possibles
    bool = ismember(point2, neighs);
    bool2 = ismember(point2, data);
    if bool && bool2 && (size(data, 2) - find(data == point2) > 100)
        data = 10;
        return;
    end
    if bool && ~bool2
        data = unique([data point]);
        ret = checkNeighs(neighs, point2, data);
        if ret == 10
            data = 10;
            return;
        end
        data = unique([data ret]);
    end
end
end

