%Circuit main

%In this example, the average load will require 900 Hz if to execute.

sim_time = 100; % microseconds

max_latency = 5;

f_curr = 1100; % MHz
f_map = [750;800;850;900;950;1000;1050;1100]; 
% example f_map, different freq. ranges may be found to be optimal

power_curr = 0;
power_next = 0;
sleep_power = 0;

v_curr = 1.8;
v_map = [];  
%v_map to be calculated based on temperature range, -10 to 110 degrees Celsius, 
%broken into 8 ranges of ~15 degrees (not necessary equal)
            
R = 1;
C = 1;
counter = 0;
counter_bits = 3;
counter_size = exp(2,counter_size);

power = 0;

main loop

while (sim_time > 0)
    
    %what should this module be based on? Stall should be affected by
    %frequency changes (i.e. if freq is higher stalls should increase
    stall = getStall(f_curr); 
    
    capac_value = updateStaller(stall,(1/f_curr),R,C);
    
    d2 = d1;
    d1 = getLogicValue(capac_value);
    if (d2 == 1)
        counter = counter + 1;
        if (counter > counter_size)
            counter = counter_size;
        end
    else
        counter = counter - 1;
        if (counter < 0)
            counter = 0;
        end
    end
    
    
    %random? based on computation? look at realistic model of this, random
    %would be easier
    temp = get_temp(); 
    
    %we can't push a new frequency every clock cycle, need to look into
    %this
    f_next = get_lut_value(temp,f_curr,counter);
    
    %(if not stalling, and static power if stalling? not necessarily (think OOO). Hmm)
    %need a clear definition for stalling
    power = power + A*v_curr*v_curr;
   
    sim_time = sim_time - 1/f_curr;
end




