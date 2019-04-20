function [b1Pyr b2Pyr]  = Grouping_Gabor(img,params)
%Calculates grouping and border ownership for the input image im
%
%Inputs:
%   im - image structure on which to perform grouping and border ownership
%   params
%
%Outputs:
%   g - grouping pyramid
%
%By Alexander Russell and Stefan Mihalas, Johns Hopkins University, 2011


%% EXTRACT EDGES
fprintf('\nExtracting center surrounds and edges on:\n');
for m = 1:size(img,2)
    fprintf('Channel %d of %d : %s \n',m,size(img,2),img{m}.type);
    map = img{m}.data;
    imPyr{m} = makePyramid(map,params);
    %% -----------------Edge Detection ------------------------------------
    EPyr{m} = edgeEvenPyramid(imPyr{m},params);
    [OPyr{m} ~] = edgeOddPyramid(imPyr{m},params);
    cPyr{m} = makeComplexEdge(EPyr{m},OPyr{m});
    %% ----------------make image pyramid ---------------------------------
        csPyr{m} = csPyramid(imPyr{m},params);
        %seperate Center Surround pyramid into positive and negative components
        %csPyrL - On center pyramid --> extracts 'light objects'
        %csPyrD - Off center pyramid --> extracts 'dark objects'
        [csPyrL{m} csPyrD{m}] = seperatePyr(csPyr{m});
        [csPyrL{m} csPyrD{m}] = normCSPyr2(csPyrL{m},csPyrD{m});
end

fprintf('\nAssigning border ownership on: \n');

%% GENERATE BORDER OWNERSHIP AND GROUPING MAPS
for m = 1:size(img,2)
    fprintf('Channel %d of %d : %s \n',m,size(img,2),img{m}.type);
    %Get border Ownership Pyramids using Odd Simple cells
    [bPyr1_1{m} bPyr2_1{m} bPyr1_2{m} bPyr2_2{m}] = borderPyramidOdd(csPyrL{m},csPyrD{m},cPyr{m},cPyr{m},cPyr{m},cPyr{m},params);
    
    bPyr1_1{m} = rectifyPyr(bPyr1_1{m},0);
    bPyr2_1{m} = rectifyPyr(bPyr2_1{m},0);
    bPyr1_2{m} = rectifyPyr(bPyr1_2{m},0);
    bPyr2_2{m} = rectifyPyr(bPyr2_2{m},0);
    b1Pyr{m} = sumPyr(bPyr1_1{m},bPyr1_2{m});
    b2Pyr{m} = sumPyr(bPyr2_1{m},bPyr2_2{m});
 
end


end



