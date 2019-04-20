function [temporal_out_s, temporal_out_w] = computeTemporalFiltering(frames)
% Get motion output 
%
% Input: frames
%
% Output: strongly phasic and weakly phasic motion output
%
% Computes motion output using temporal filter described in Parkhurst
% thesis (strongly phasic an weakly phasic)
%

%Strongly Phasic
r(1,1,1,:) = fliplr(makeTemporalFilter('strong'));

%Initialize motion out
motion_out = cell(1,1);

motion_out{1} = convn(frames,r,'same');
for i = 1:size(motion_out{1},4)
    motion_out{1}(:,:,:,i) = motion_out{1}(:,:,:,i).^2;
    motion_out{1}(:,:,:,i) = normalizeImage(im2double(squeeze(motion_out{1}(:,:,:,i))));
end

temporal_out_s = motion_out{1};
clear motion_out;
clear r;

%%
%Weakly Phasic
r(1,1,1,:) = fliplr(makeTemporalFilter('weak'));

%Initialize motion out
motion_out = cell(1,1);

motion_out{1} = convn(frames,r,'same');
for i = 1:size(motion_out{1},4)
    motion_out{1}(:,:,:,i) = motion_out{1}(:,:,:,i).^2;
    motion_out{1}(:,:,:,i) = normalizeImage(im2double(squeeze(motion_out{1}(:,:,:,i))));
end

temporal_out_w = motion_out{1};
