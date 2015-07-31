%Circuit main

%For voltage range calculation, frequency range calculation, and lut value
%calculations, we should try to use good approximations but the designer
%can fill in the LUT however they want, that's not a claim of this
%invention

%time unit is one microsecond (slow processor. scale freq up to make
%frequency and power calculations realistic)

sim_time = 100000; 

max_latency = 1000;

T_min = 18;
T_nom = 18;
T_max = 30;
size = 8;

T_curr = T_nom; % better for simulation to work with periods instead of freqs
T_map = getPeriodMap(T_nom,T_min,T_max,size);
%T_map = [18;19;20;22;24;26;28;30]; 
% this is just an example T_map, different period (freq) ranges may be 
%found to be optimal. This should be calculated by some function given a
%range. Or should we just evenly space it. Or are there some frequencies
%which are easier for a PLL to produce than others?

power_curr = 0;
power_next = 0;
sleep_power = 0;

temp_min = -10;
temp_max = 110; %degrees celsius

%need to find formula to find min, max voltages realistic over temperature
%range given nominal
v_nom = 1.8;
v_min = 1.4;
v_max = 2.4;


v_curr = v_nom;
v_next = v_curr;
v_map = getVoltages(T_map,v_nom,v_min,v_max,size);  
%v_map to be calculated based on temperature range, -10 to 110 degrees Celsius, 
%broken into 8 ranges of ~15 degrees (not necessary equal)

T_const = max_latency/4;
R = 100;%ohms
C = T_const/R;

counter = 0;
counter_bits = 4;
counter_size = exp(2,counter_size);

workload = 0.6; % workload*max_freq*sim_time = total number of work clocks

power = 0;

T_sample = T_const/2;

temp_curr = 30;
temp_last = 30;

%this returns a 'cdf' of the number of clocks of work that have been assigned
%at each unit of time
work_vector = getWorkVector(sim_time, T_max, workload);
work_queue = 0;

t = 0;
while (t < sim_time)
    %Just returns 1 if queue is empty
    stall = getStall(work_queue);
    
    capac_value = updateCharge(stall,capac_value,T_const);
    
    if (mod(t, T_curr) == 0)
        
        if (work_queue > 0)
            work_queue = work_queue - 1;
            
            %need a clear definition for stalling, need to figure out
            %sleep mode
            energy = energy + A*v_curr*v_curr; 
        else
            energy = energy + static/T_curr?; %How do we calculate power accurately?
        end
    end
    
    if (mod(t,T_sample) == 0)
       
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
        %would be easier and probably ok. Should be based on last
        %temperature but since we are sampling temp only on sampling clock
        %you can probably allow it to vary a fair amount from reading to
        %reading.
        last_temp = temp_curr;
        temp_curr = getTemp(last_temp,T_curr,T_map,v_curr,v_map);
        
        %we can't push a new frequency every clock cycle, need to look into
        %this
        
        [T_next, v_next] = get_lut_value(temp_curr,T_curr,v_curr,counter,T_map,v_map);
        v_curr = v_next;
    end
    
    
    t = t + 1;
end




