function [ v_work ] = getWorkVector(sim_time, f_curr, workload)
%Returns the workload. Note that this may not be the most realistic way to
%simulate a processor workload, even for the special scenarios we are
%describing (interrupt based, sporadic workloads, low latency). The
%workload is defined as a vector that for each time value may have a number
%that represents an interrupt at the time value corresponding to its index
%which requires a number of clocks to satisfy equal to its value. For the
%latency to be satisfied, we should log how many interrupts are STARTED to
%be serviced within the latency time. This is where our solution should be better.


end

