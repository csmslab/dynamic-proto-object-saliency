function g = makeSpatialFilter(params)
%makes gabor based orientation selective filters
%
%Inputs:
%
%params(1) - w: spatial frequency parameter
%params(2) - theta: orientation
%params(3) - phi : spatial phase
%params(4) - x : 
%params(5) - y : odd amplitude
%
%Outputs:
%
%g - gabor filter mask

w = params(1);
theta = params(2);
phi = params(3);
sigma = 2;
x = -3*sigma:3*sigma;
y = -3*sigma:3*sigma;
[X,Y] = meshgrid(x,y);
g = cos(w.*(X.*cos(theta)-Y.*sin(theta))+phi).*exp(-(X.^2+Y.^2)/(2.*sigma));