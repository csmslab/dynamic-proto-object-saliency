function img = generateChannels(imgs,params)
%Generates the data structure to hold the different channels the algorithm
%operates on
%
%Inputs:
%im - input image to algorithm
%params - model parameter structure
%
%outputs:
%img - data structure holding different feature channels

[in,in_orient,R,G,B,Y] = makeColors(imgs);
%Generate color opponency channels
rg = R-G;
by = B-Y;
gr = G-R;
yb = Y-B;
%Threshold opponency channels
rg(rg<0) = 0;
gr(gr<0) = 0;
by(by<0) = 0;
yb(yb<0) = 0;

for c = 1:length(params.channels)
    if strcmp(params.channels(c),'I')
        %intensity
        img{c}.subtype{1}.data = in;
        img{c}.subtype{1}.type = 'Intensity';
        img{c}.type = 'Intensity';
    elseif strcmp(params.channels(c),'C')
        img{c}.type = 'Color';
        img{c}.subtype{1}.data = rg;
        img{c}.subtype{1}.type = 'Red-Green Opponency';
        
        img{c}.subtype{2}.data = gr;
        img{c}.subtype{2}.type = 'Green-Red Opponency';
        
        img{c}.subtype{3}.data = by;
        img{c}.subtype{3}.type = 'Blue-Yellow Opponency';
        
        img{c}.subtype{4}.data = yb;
        img{c}.subtype{4}.type = 'Yellow-Blue Opponency';
    elseif strcmp(params.channels(c),'O')
        %orientation
        img{c}.type = 'Orientation';
        img{c}.subtype{1}.data = in_orient;
        img{c}.subtype{1}.ori = 0; %orientation channel angle
        img{c}.subtype{1}.type = 'Orientation';
        
        img{c}.subtype{2}.data = in_orient;
        img{c}.subtype{2}.ori = pi/4;
        img{c}.subtype{2}.type = 'Orientation';
        
        img{c}.subtype{3}.data = in_orient;
        img{c}.subtype{3}.ori = pi/2;
        img{c}.subtype{3}.type = 'Orientation';
        
        img{c}.subtype{4}.data = in_orient;
        img{c}.subtype{4}.ori = 3*pi/4;
        img{c}.subtype{4}.type = 'Orientation';
    end
end