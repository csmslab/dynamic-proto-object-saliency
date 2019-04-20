%Read video frames from a vid file (e.g. mp4, .mov)
%vid = getVideo('vid_file_here');

num_frames_to_run = 2;

%Or, load video
vid = load('vid_leopard.mat');
vid = vid.vid_leopard;

%Run limited number of frames
num_frames_to_run = min(num_frames_to_run,size(vid,4));
vid = vid(:,:,:,1:num_frames_to_run);

%run dynamic saliency model
dyn_sal = runProtoSalDynamic(vid);

%play resulting dynamic saliency map
playback_framerate = 24;
playSaliency(vid,dyn_sal.sal_map, playback_framerate);