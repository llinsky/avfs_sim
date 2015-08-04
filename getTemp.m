function [ next_temp ] = getTemp(last_temp,T_curr,T_map,v_curr,v_map)
%Returns a somewhat stochastic temperature reading

bias = 0;
%TODO: bias temperature based on current operating conditions
t_index = 0;
for i = 1:(size(T_map))
    if (i == T_curr)
        t_index = i;
    end
end

v_index = 0;
for i = 1:(size(v_map))
    if (i == v_curr)
        v_index = i;
    end
end

total = v_index + t_index;

if (total > 6)
    bias = 0.2;
elseif (total > 4)
    bias = 0.1;
elseif (total > 2)
    bias = -0.1;
else
    bias = -0.1;
end


randnum = rand;

randnum = randnum - 0.5 + bias;

next_temp = last_temp + randnum*0.01;

if (next_temp >= 110)
    next_temp = 110;
elseif (next_temp <= -10)
    next_temp = -10;
end

end

