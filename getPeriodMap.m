function [ T_map ] = getPeriodMap(T_nom,T_min,T_max,size)
%Provides an array of periods (1/frequency) that are the possible values of
%the reference clock. Used by the look up table. Can probably just divide
%up the range into equal segments.
%  

if (size < 1)
    disp('error');
elseif (T_min > T_max) %should min be defined in terms of period or frequency? I need to clarify
    disp('error2');
end

if (size == 1)
    step = 0;
else
    step = (T_max - T_min)/(size-1);
end

T_map = zeros(size,1);

T_map(1) = T_min;
T_map(size) = T_max;

for index=1:size
    T_map(index) = T_min + (index-1)*step;
end

