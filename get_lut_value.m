%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function containing logic to output the next frequency and voltage
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  [T_next, v_next] = get_lut_value(temp_curr,T_curr,v_curr,counter,T_map,v_map)
	P = CV^2*A*f
	-how does freq depend on voltage?
	f = (Vdd - Vth)^(alpha)/k*Vdd, k is constant, 1<alpha<2
	-how does threshold voltage depend on temperature?
	threshold voltage decreases as temperature increases...
	I would maybe just define Vth=(-a)T + b, a and b constants, T<some upper bound
	%select correct T value 
	
	%select correct V value 
	
	
	%leo tentative template

	countersize = 15; %(max value)
	estimated_current_workload = (counter/countersize);
	
	T_max = estimated_current_workload/T_curr; %T_max = f_min to maintain a 100 percent workload (and not fall behind) 
	
	calculation_time_ratio = 1;
	
	infinity = 9999999;
	bestPower = infinity;
	
	power = 0;
	
	for j=1:(size(T_map))
		if (T_map(j) > T_max)
			continue;
		end
		
		calculation_time_ratio = T_map(j)/T_max; %perhaps should replace T_max with T_map(size(T_map)) for stable outputs?
	
		for i=1:(size(v_map))
		
			v_min = function1(temp_curr, T_map(j)); %this is somewhat arbitrary, just use a somewhat realistic value for an existing CMOS platform.
		
			if (v_map(i) < v_min)
				continue;
			end
		
			power = function2(T_map(j),v_map(i)) * calculation_time_ratio; %this is actually energy in a sense
			if (power < bestPower)
				bestPower = power;
				T_next = T_map(j);
				v_next = v_map(i);
			end
		end
	end

end