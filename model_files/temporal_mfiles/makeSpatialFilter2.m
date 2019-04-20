function [g,X,Y,T] = makeSpatialFilter2(params)
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
sigma = 1;
x = -4*sigma:sigma/10:4*sigma;
y = -4*sigma:sigma/10:4*sigma;
z = -4*sigma:sigma/10:4*sigma;

[X,Y,T] = meshgrid(x,y,z);
sx = sigma;
st = sigma;
wx0 = 1;
wt0 = 1;
sy = sigma;
wy0 = 1;


gox = 1./(sqrt(2*pi).*sx).*exp(-X.^2./(2.*sx.^2)).*sin(2.*pi.*wx0.*X);
gex = 1./(sqrt(2*pi).*sx).*exp(-X.^2./(2.*sx.^2)).*cos(2.*pi.*wx0.*X);
goy = 1./(sqrt(2*pi).*sy).*exp(-Y.^2./(2.*sx.^2)).*sin(2.*pi.*wy0.*Y);
gey = 1./(sqrt(2*pi).*sy).*exp(-Y.^2./(2.*sx.^2)).*cos(2.*pi.*wy0.*Y);
got = 1./(sqrt(2*pi).*st).*exp(-T.^2./(2.*st.^2)).*sin(2.*pi.*wt0.*T);
get = 1./(sqrt(2*pi).*st).*exp(-T.^2./(2.*st.^2)).*cos(2.*pi.*wt0.*T);

g = get.*gex+got.*gox;