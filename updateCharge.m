function [ c_next ] = updateCharge(stall,capac_value,T_const,v_curr)
%Just updates how much charge is on the capacitor

if (stall == 1)
    c_next = capac_value + (v_curr - capac_value)/T_const; %TODO: this isn't the real formula
else
    c_next = capac_value - capac_value/T_const; %TODO: this isn't the real formula
end

end

