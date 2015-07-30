function [ bit ] = getLogicValue(capac_value)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

bit = 0;
d_FF_threshold = 0.83; %TODO: I made this up

if (capac_value > 1.05*d_FF_threshold)
    bit = 1;
elseif (capac_value > 0.95*d_FF_threshold)
    rand = randm(1,1);
    
    if (rand > 0.5)
        bit = 1;
    end
end

end

