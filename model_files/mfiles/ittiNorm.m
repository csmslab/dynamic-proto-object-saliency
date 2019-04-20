function [h, feature_maps] = ittiNorm(gPyr,collapseLevel)
%function [h individual_maps] = ittiNorm(gPyr,collapseLevel)
%Normalizes and combines the grouping pyramids into a saliency map
%This is performed in an identical manner to how the feature maps in the
%Itti et al (1998) paper are combined
%
%Inputs:
%gPyr - grouping pyramid
%collapseLevel - final merge level of all the conspicuity maps
%
%Outputs:
%h - saliency map data structure
%
%By Alexander Russell and Stefan Mihalas, Johns Hopkins University, 2012

fprintf('\nNormalizing Grouping Pyramids\n');
for m = 1:size(gPyr,2)
      if ~strcmp(gPyr{m}.type,'Orientation')    
        %first sum subtypes across levels then normalize each level
        FM = [];
        for l = 1:size(gPyr{m}.subtype{1},2)
            FM(l).data= zeros(size(gPyr{m}.subtype{1}(l).data,1),size(gPyr{m}.subtype{1}(l).data,2));
            for sub = 1:size(gPyr{m}.subtype,2)
                tmp_normed = maxNormalizeLocalMax(gPyr{m}.subtype{sub}(l).data,[0 10]);
                FM(l).data = FM(l).data + tmp_normed;
            end
        end
        for l = 1:size(FM,2)
            CML(l).data = FM(l).data;
        end
        CM{m}.data = zeros(size(FM(collapseLevel).data));
        for l = 1:size(CML,2)
            CM{m}.data = CM{m}.data + imresize(CML(l).data,[size(FM(collapseLevel).data,1) size(FM(collapseLevel).data,2)]);
        end
        
    elseif strcmp(gPyr{m}.type,'Orientation')
        %normalize pyramids for each angle separately then merge
        FM = gPyr{m}.subtype;
        CM{m}.data = zeros(size(FM{1}(collapseLevel).data));
        clear CML
        for sub = 1:size(FM,2)
            CML{sub}.data = zeros(size(FM{1}(collapseLevel).data));
            for l = 1:size(FM{m},2)
                FML{sub}(l).data = maxNormalizeLocalMax(FM{sub}(l).data,[0 10]);
                CML{sub}.data = CML{sub}.data + imresize(FML{sub}(l).data,[size(FM{1}(collapseLevel).data,1) size(FM{1}(collapseLevel).data,2)]);
            end
            CM{m}.data = CM{m}.data + CML{sub}.data;
        end
            
    else
        error('Please ensure algorithm operates on known feature types');
    end
end
h.data = zeros(size(CM{1}.data));

feature_maps = zeros(size(CM{1}.data,1),size(CM{1}.data,2),size(CM,2));
weights = [1 1 1];
weights = weights ./ size(CM,2);
for m = 1:size(CM,2)
    h.data = h.data + weights(m).*maxNormalizeLocalMax(CM{m}.data,[0 10]);
    feature_maps(:,:,m) =  maxNormalizeLocalMax(CM{m}.data,[0 10]);
end

end
        