function [h] = runProtoSalDynamic(frames)
%Runs the dynamic proto-object based saliency algorithm (with motion)
%
%inputs:
%   frames - numRows x numCols x 3 x numFrames
%
%Johns Hopkins Univeristy, 2017
%

fprintf('\n\nStart Dynamic Proto-Object Saliency Model\n')

%generate parameters
params = makeDefaultParams;

%compute motion
[temp_out_strong, temp_out_weak] = computeTemporalFiltering(frames);

%initialize outputs
h = struct;
sal = zeros(size(frames,1), size(frames,2), size(frames,4));
all_maps = zeros(size(frames,1), size(frames,2),size(frames,4),3);
imgs = zeros(size(frames,1),size(frames,2),3,numel(params.channels));

for f = 1:size(frames,4)
    %display frame being processed
    fprintf('\nStarting Frame %d of %d\n\n',f,size(frames,4));
    
    %time each frame
    tic    
    
    %get current frame
    im = normalizeImage(im2double(squeeze(frames(:,:,:,f))));
    
    %get strongly phasic motion and store in imgs (intensity channel)
    imgs(:,:,:,1) = squeeze(temp_out_strong(:,:,:,f));
    
    %get weakly phasic motion and store in imgs (color channel)
    imgs(:,:,:,2) = squeeze(temp_out_weak(:,:,:,f));
    
    %get static image and store in imgs (orientation channel)
    imgs(:,:,:,3) = im;
    
    %generate channels
    img = generateChannels(imgs,params);

    %generate border ownership structures
    [b1Pyr, b2Pyr]  = makeBorderOwnership(img,params);
    
    %generate grouping pyramids
    gPyr = makeGrouping(b1Pyr,b2Pyr,params);
        
    %normalize grouping pyramids and combine into final saliency map
    [h_curr, ind_maps] = ittiNorm(gPyr,3);
    
    %store current saliency output and resize to original image size
    h_curr.data = imresize(h_curr.data,[size(im,1),size(im,2)]);
    
    %store each channel conspicuity output (saliency within channel)
    for map_cnt = 1:3
        curr_map = imresize(ind_maps(:,:,map_cnt),[size(im,1),size(im,2)]);
        all_maps(:,:,f,map_cnt) = curr_map;
    end
    
    %Get sal individual maps
    sal(:,:,f) = h_curr.data;
    
    %display time to run
    fprintf('\nFrame %d of %d Processing Complete.\n',f,size(frames,4));
    toc
    
    %display output
    imagesc(sal(:,:,f));
    colormap jet
    drawnow;
    
end

%output
h.sal_map = sal;                %dynamic saliency map
h.conscipuity_maps = all_maps;  %dynamic conspicuity maps (by channel)

fprintf('\nDone\n')