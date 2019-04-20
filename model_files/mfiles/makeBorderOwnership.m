function [b1Pyr b2Pyr]  = makeBorderOwnership(img,params)
%Calculates grouping and border ownership for the input image im
%
%Inputs:
%   im - image structure on which to perform grouping and border ownership
%   params
%
%Outputs:
%   g - grouping pyramid
%
%By Alexander Russell and Stefan Mihalas, Johns Hopkins University, 2012


%% EXTRACT EDGES

for m = 1:size(img,2)
    fprintf('\nAssigning Border Ownership on ');
    fprintf(img{m}.type);    
    fprintf(' channel:\n');    
    for sub = 1:size(img{m}.subtype,2)        
        fprintf('Subtype %d of %d : ',sub,size(img{m}.subtype,2));
        map = img{m}.subtype{sub}.data;
        imPyr = makePyramid(map,params);
        %% -----------------Edge Detection ------------------------------------
        EPyr = edgeEvenPyramid(imPyr,params);
        [OPyr ~] = edgeOddPyramid(imPyr,params);
        cPyr = makeComplexEdge(EPyr,OPyr);
        
        %% ----------------make image pyramid ---------------------------------
        if strcmp(img{m}.subtype{sub}.type ,'Orientation') %generate gabor pyramid
            fprintf('%d deg\n',rad2deg(img{m}.subtype{sub}.ori));
            csPyr = gaborPyramid(imPyr,img{m}.subtype{sub}.ori,params);
        else %generate normal center surround pyramid            
            fprintf(img{m}.subtype{sub}.type);
            fprintf('\n');
            csPyr = csPyramid(imPyr,params);
        end
        [csPyrL csPyrD] = seperatePyr(csPyr);
        [csPyrL csPyrD] = normCSPyr2(csPyrL,csPyrD);
        
        %% GENERATE BORDER OWNERSHIP AND GROUPING MAPS
        %Get border Ownership Pyramids
        [bPyr1_1 bPyr2_1 bPyr1_2 bPyr2_2] = borderPyramid(csPyrL,csPyrD,cPyr,params);
        b1Pyr{m}.subtype{sub} = sumPyr(bPyr1_1,bPyr1_2);
        b2Pyr{m}.subtype{sub} = sumPyr(bPyr2_1,bPyr2_2);
        if strcmp(img{m}.subtype{sub}.type,'Orientation')
            b1Pyr{m}.subname{sub} =   [num2str(rad2deg(img{m}.subtype{sub}.ori)) ' deg']; 
            b2Pyr{m}.subname{sub} =   [num2str(rad2deg(img{m}.subtype{sub}.ori)) ' deg']; 
        else
            b1Pyr{m}.subname{sub} =   img{m}.subtype{sub}.type; 
            b2Pyr{m}.subname{sub} =   img{m}.subtype{sub}.type; 
        end
    end
    b1Pyr{m}.type = img{m}.type;
    b2Pyr{m}.type = img{m}.type;
    
end



