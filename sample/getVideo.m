function vid_frames = getVideo(video)

warning('off','all');

%Read in video and return frames
videoFReader = vision.VideoFileReader(video);

%get each frame and store in vid_frames
frame_cnt = 1;
while (~isDone(videoFReader))
    fprintf("\nReading frame %d",frame_cnt);
    curr_frame = step(videoFReader);
    vid_frames(:,:,:,frame_cnt) = curr_frame;
	frame_cnt = frame_cnt + 1;
end

release(videoFReader);
vid_frames = double(vid_frames);
warning('off','all');

end