function [motion_out, vid_out] = getMotionOutput( frames, params, temporal_filter_type )
% Get motion output 
%
% Input: frames
%        parameters
%
% Output: cell containing all motion output at each level
%
% Computes motion output using temporal filter described in Parkhurst
% thesis
%

%Check number of in/out arguments
if (nargin ~= 3)
    error('Incorrect number of inputs for getMotionOutput');
end
if (nargout ~= 2)
    error('One output argument required for getMotionOutput');
end

%Convert frames to intensity
framesi = rgb2int_frames(frames);

%Get number of frames
num_frames = size(frames,4);

%Get number of levels
depth = params.maxLevel;

%Strongly Phasic
r(1,1,:) = fliplr(makeTemporalFilter(temporal_filter_type));

%Initialize motion out
motion_out = cell(1,depth);
vid_out = cell(1,depth);

%Set first level
vid_out{1} = framesi;

%Set remaining levels
for l = 2:depth
    for f = 1:num_frames
        if strcmp(params.csPrs.downSample,'half')%downsample halfoctave
            vid_out{l}(:,:,f) = imresize(vid_out{l-1}(:,:,f),0.7071,'cubic');
        elseif strcmp(params.csPrs.downSample,'full') %downsample full octave
            vid_out{l}(:,:,f) = imresize(vid_out{l-1}(:,:,f),0.5,'cubic');
        else
            error('Please specify if downsampling should be half or full octave');
        end
    end
end

for l = 1:depth
    
    motion_out{l} = convn(vid_out{l},r,'same');

    for i = 1:size(motion_out{l},3)
        motion_out{l}(:,:,i) = motion_out{l}(:,:,i).^2;
        motion_out{l}(:,:,i) = normalizeImage(im2double(squeeze(motion_out{l}(:,:,i))));
    end
end
