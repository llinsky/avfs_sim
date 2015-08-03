function [ bit ] = getLogicValue(capac_value)
%returns logic value from voltage

bit = 0;
d_FF_threshold = 1.3; %TODO: I made this up

if (capac_value > 1.1*d_FF_threshold)
    bit = 1;
elseif (capac_value > 0.9*d_FF_threshold)
    rand = randm(1,1);
    
    if (rand > 0.5)
        bit = 1;
    end
end

end

