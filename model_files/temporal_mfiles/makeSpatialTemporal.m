function f = makeSpatialTemporal()
%makes a spatial temporal filter

r = makeTemporalFilter('strong');
g = makeSpatialFilter([0.5*pi,0,0]);

for i = 1:numFrames
    
    
    
end