%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function containing logic to output the next frequency and voltage
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  [T_next] = throttleFreq(T_curr,counter,T_map)
	index = find(T_map==T_curr,1);
	%need to define threshold values
	if(counter>uthresh)
		T_next = T_map[index+1];
	else if (counter<lthresh)
		T_next = T_map[index-1];
	else
		T_next=T_map[index];
	
end