function [ stall ] = getStall( work_queue )
%processor is stalling if there is no work in the queue

if (work_queue > 0)
    stall = 0;
elseif (work_queue == 0)
    stall = 1;
else
    stall = 1;
    printf('error');

end

