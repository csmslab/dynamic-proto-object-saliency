function r = makeTemporalFilter(params)
%makes the temporal filter for the seperable spatio-temporal filter.
%
%Inputs:
%
%nargin = 1
%   params - type of filter to make:
%            'strong' : strongly phasic filter
%            'weak' : weakly phasic filter
%
%nargin = 6
%
%   params - define filter coefficients
%
%   params(1) - alpha : filter amplitude control
%   params(2) - beta : filter amplitude control
%   params(3) - tau : time delay
%   params(4) - delta : phasic control parameter
%   params(5) - tmax: time length of filter
%   params(6) - dt : time step of filter
%

warning('off','all')

if (nargin ~= 1)
    error('MakeTemporalFilter requires 1 input argument');
end

if isnumeric(params) && (size(params,2) ~= 6)
    error('Input must either be a string or 6 element vector');
end

if ~isnumeric(params) == 1
    switch params
         
        case 'strong'
            alpha = -0.00161;
            beta = -0.00111;
            tau = 86.2;
            delta = 5.6;
            tmax = 250;
            dt = 24;
            
        case 'weak'
            alpha = -0.000487;
            beta = -0.000466;
            tau = 116;
            delta = 20;
            tmax = 250;
            dt = 24;
            
        otherwise
            error('Unknown filter type requested');
    end
else
    alpha = params(1);
    beta = params(2);
    tau = params(3);
    delta = params(4);
    tmax = params(5);
    dt = params(6);
end

tstep = 1/dt*1000;
t = 1:1:tmax;
rc = alpha.*(t-tau-delta).*exp(beta.*(t-tau).^2);

for i = 1:floor(250/tstep)
    r(i) = sum(rc((i-1)*tstep+1:i*tstep));
end
r = r./sum(sum(r>0));

if  ~strcmp(params,'weak') == 1
    r = r - mean(r);
end

warning('on','all')