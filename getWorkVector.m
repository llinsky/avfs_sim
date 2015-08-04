function [ v_work ] = getWorkVector(sim_time, T_min, workload)
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
event_prob = workload/T_min/avg_req_size*10;

work_assigned = 0;
v_work = zeros(1,sim_time);

for i=1:sim_time
    randnum = rand;
    if (randnum <= event_prob)
        event_type = 1;
        randnum = rand;
        for j = 1:size(percs_cdf)
            if (randnum <= percs_cdf(j))
                event_type = j;
                break;
            end
        end
        work_assigned = work_assigned + tasks(event_type);
    end
    
    v_work(i) = work_assigned;
end

v_work = v_work/10;

end

