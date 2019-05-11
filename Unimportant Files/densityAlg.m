%Finds differences in density of white pixels
%Assume sizer is even and that can be split evenly
%Essentially, tries to get rid of big clumps of pure white
%params 8, 10 are good
function [newImage] = densityAlg(imageData, sizer, distance)
length = size(imageData, 2);
newImage = zeros(length, length);
averager1 = ones(sizer/2, sizer);
averager2 = ones(sizer, sizer/2);
area = sizer*sizer/2;
for xx = 1:sizer/2:length-sizer
    for yy = 1:sizer/2:length-sizer
        aa1 = xx:xx+sizer/2;
        aa2 = xx+sizer/2:xx + sizer;
        aa = xx:xx+sizer;
        bb1 = yy:yy+sizer/2;
        bb2 = yy+sizer/2:yy+sizer;
        bb = yy:yy+sizer;
        
        i1 = imageData(bb, aa1);
        i2 = imageData(bb, aa2);
        i3 = imageData(bb1, aa);
        i4 = imageData(bb2, aa);
        
        density1 = round((i1(1:area)*averager1(1:area).'));
        density2 = round((i2(1:area)*averager1(1:area).'));
        density3 = round((i3(1:area)*averager2(1:area).'));
        density4 = round((i4(1:area)*averager2(1:area).'));
        
        distance1 = (density1 - density2)^2;
        distance2 = (density3 - density4)^2;
        
        if distance1>= distance2
            if distance1 >= distance
                if density1 >= density2 
                    newImage(bb, aa1) = i1;
                else
                    newImage(bb, aa2) = i2;
                end
            end
        else
            if distance2 >= distance
                if density3 >= density4 
                    newImage(bb1, aa) = i3;
                else
                    newImage(bb2, aa) = i4;
                end
            end
        end
    end
end
