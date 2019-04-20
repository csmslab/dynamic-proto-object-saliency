function pyr = makePyramid(img,params)
%Makes the centre surround pyramid using a CS mask on each
%layer of the image pyramid
%
%inputs :
%img - input image
%params - model parameter structure
%
%outputs :
%pyr - image pyramid
%
%By Alexander Russell and Stefan Mihalas, Johns Hopkins University, 2012

if (nargin ~= 2)
    error('Incorrect number of inputs for makePyramid');
end
if (nargout ~= 1)
    error('One output argument required for makePyramid');
end

depth = params.maxLevel;

pyr(1).data = img;
for l = 2:depth
    if strcmp(params.csPrs.downSample,'half')%downsample halfoctave
        pyr(l).data = imresize(pyr(l-1).data,0.7071,'cubic');
    elseif strcmp(params.csPrs.downSample,'full') %downsample full octave
        pyr(l).data = imresize(pyr(l-1).data,0.5,'cubic');
    else
        error('Please specify if downsampling should be half or full octave');
    end
end
