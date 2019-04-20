function [newPyr1 newPyr2] = normCSPyr(csPyr1, csPyr2)

for l = 1:size(csPyr1,2)
        temp = sumPyr(csPyr1,csPyr2);
        norm = maxNormalizeLocalMax(temp(l).data,[0 10]);
        if max(max(temp(l).data))~=0
            scale = max(max(norm))/max(max(temp(l).data));
        else
            scale = 0;
        end
        newPyr1(l).data = scale*csPyr1(l).data;
        newPyr2(l).data = scale*csPyr2(l).data;
end