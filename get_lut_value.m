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
	v_min = f(T_curr);
	countersize = 15; (max value)
	estimated_current_workload = (counter/countersize);
	
	%For now let's say that we want a 90% workload. Find optimal power given allowable voltages and frequencies to maintain 90% workload or lower
	
	for i=1:(size(v_map))
		if (v_map(i) < v_min)
			continue;
		end
		for j=1:(size(T_map))
			
			
		end
	end

end