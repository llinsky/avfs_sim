function [ v_map ] = getVoltages(T_map,v_nom,v_min,v_max,size)
%Range of possible voltages. Probably can just split up range into even
%steps

if (size < 1)
    disp('error');
elseif (v_min > v_max) 
    disp('error2');
end

if (size == 1)
    step = (v_max - v_min)/(size-1);
else
    step = 0;
end

v_map = zeros(size,1);

v_map(1) = v_min;
v_map(size) = v_max;

for index=1:size
    v_map(index) = v_min + (index-1)*step;
end


end

