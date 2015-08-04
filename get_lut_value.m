%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function containing logic to output the next frequency and voltage
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  [T_next, v_next] = get_lut_value(temp_curr,T_curr,v_curr,counter,T_map,v_map)

	countersize = 15; %(max value)
	estimated_current_workload = 1-(counter/countersize);
	
	T_max = T_curr/estimated_current_workload; %T_max = f_min to maintain a 100 percent workload (and not fall behind) 
	
	activity_ratio = 1;
	
	infinity = 9999999;
	bestPower = infinity;
	T_next = 0;
	power = 0;
	v_next =0;
    
	for j=1:(size(T_map))
		if (T_map(j) > T_max)
			disp('first condition skip');
            continue;
		end
		
		activity_ratio = T_map(j)/T_max; %perhaps should replace T_max with T_map(size(T_map)) for stable outputs?
	
		for i=1:(size(v_map))
		
			v_min = (-0.03*(temp_curr - 30) + 0.5)*(T_curr/T_map(4));
																							
			if (v_map(i) < v_min)
				disp('second condition skip');
                continue;
			end
		
			power = 4*10^(-9)*(1/T_map(j))*v_map(i)^2 * activity_ratio  +  v_map(i)^1.85* (1-activity_ratio); %Dynamic + static, this is actually energy in a sense								
			disp('Power='+power);
            if (power < bestPower)
				bestPower = power;
				T_next = T_map(j);
				v_next = v_map(i);
			end
		end
	end

end