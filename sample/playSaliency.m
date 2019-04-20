function playSaliency( orig_vid, dyn_sal, framerate )

%Play video
num_frames = size(orig_vid,4);

fprintf("\n\nTo Stop Video:\n\nClick Here In Command Window\nThen Press Ctrl + C.\n");

while 1
    for k = 1:num_frames
        figure(1);
        
        subplot(1,2,1);
        imshow(orig_vid(:,:,:,k));
        axis tight
        subplot(1,2,2);

        imagesc(dyn_sal(:,:,k));
        axis equal
        axis tight
        colormap jet
        pause(1/framerate);
    end
end

end

