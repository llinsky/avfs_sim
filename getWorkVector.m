function [ v_work ] = getWorkVector(sim_time, T_max, workload)
%Returns the workload. Note that this may not be the most realistic way to
%simulate a processor workload, even for the special scenarios we are
%describing (interrupt based, sporadic workloads, low latency). The
%workload is defined as a vector that for each time value may have a number
%that represents an interrupt at the time value corresponding to its index
%which requires a number of clocks to satisfy equal to its value. For the
%latency to be satisfied, we should log how many interrupts are STARTED to
%be serviced within the latency time. This is where our solution should be better.

tasks = [10 20 60 200];
percs = [0.2 0.1 0.4 0.3];
percs_cdf = [0.2 0.3 0.7 1];

avg_req_size = tasks*(percs');

%event_prob * avg_req_size / T_max = workload;
event_prob = workload/T_max/avg_req_size;

work_assigned = 0;
v_work = zeros(1,sim_time);

for i=1:sim_time
    rand = randm();
    if (rand <= event_prob)
        rand = randm();
        
        work_assigned = 0;
    end
    
    v_work(sim_time) = work_assigned;
end

end

