# Write to OS System/Device and Hardware Data Files
write() {
	[[ ! -f "$1" ]] && return 1
	chmod +w "$1" 2> /dev/null
	if ! echo "$2" > "$1" 2> /dev/null
	then
		return 1
	fi
}

# Variables
kernel="/proc/sys/kernel/"
vm="/proc/sys/vm/"
cpuset="/dev/cpuset/"
cpuctl="/dev/cpuctl/"
stune="/dev/stune/"
lmk="/sys/module/lowmemorykiller/parameters"
tcp_v4="/proc/sys/net/ipv4/"
fs="/proc/sys/fs/"
perfmgr="/proc/perfmgr/"

# Sync Data
sync

# CPU and GPU
for cpu in /sys/*/system/cpu/cpu*/cpufreq/*
do
	available_governors="$(cat "$cpu/scaling_available_governors")"
	for governor in 
	do
		if [[ "$available_governors" == *"$governor"* ]]
		then
			write "$cpu/scaling_governor" "$governor"
			break
		fi
	done
done

for cpu in /sys/*/system/cpu/cpufreq/policy*
do
	available_governors="$(cat "$cpu/scaling_available_governors")"
	for governor in 
	do
		if [[ "$available_governors" == *"$governor"* ]]
		then
			write "$cpu/scaling_governor" "$governor"
			break
		fi
	done
done

for gpu in /sys/*/kgsl/kgsl-3d0/devfreq
do
	available_governors="$(cat "$gpu/gpu_available_governor")"
	for governor in 
	do
		if [[ "$available_governors" == *"$governor"* ]]
		then
			write "$gpu/gpu_governor" "$governor"
			break
		fi
	done
done

for gpu in /sys/*/gpu/
do
	available_governors="$(cat "$gpu/gpu_available_governor")"
	for governor in 
	do
		if [[ "$available_governors" == *"$governor"* ]]
		then
			write "$gpu/gpu_governor" "$governor"
			break
		fi
	done
done

# I/O SCHEDULERS
for queue in /sys/*/*/queue
do
	available_schedulers="$(cat "$queue/scheduler")"
	for sched in none noop mq-deadline deadline kyber bfq cfq
	do
		if [[ "$available_schedulers" == *"$sched"* ]]
		then
			write "$queue/scheduler" "$sched"
			break
		fi
	done
done

for nand_flash in /sys/*/devfreq/1d84000.ufshc
do
	available_governors="$(cat "$nand_flash/available_governors")"
	for governor in performance
	do
		if [[ "$available_governors" == *"$governor"* ]]
		then
			write "$nand_flash/governor" "$governor"
			break
		fi
	done
done

# TCP CONGESTION ALGORITHM
for tcp in /proc/sys/net/*
do
	available_tcps="$(cat "$tcp/tcp_available_congestion_control")"
	for tcp_ctrl in bbr2 bbr westwood cubic reno bic
	do
		if [[ "$available_tcps" == *"$tcp_ctrl"* ]]
		then
			write "$tcp/tcp_congestion_control" "$tcp_ctrl"
			break
		fi
	done
done

# Modify to apply this parameters if all of above's parameters isn't working.
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
write /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor 
write /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor	
write /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor	
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor	
write /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor	
write /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor	
write /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor	
write /sys/devices/system/cpu/cpu8/cpufreq/scaling_governor	
write /sys/devices/system/cpu/cpu9/cpufreq/scaling_governor	
write /sys/devices/system/cpu/cpu10/cpufreq/scaling_governor 
write /sys/devices/system/cpu/cpu11/cpufreq/scaling_governor 

write /sys/devices/system/cpu/cpufreq/policy0/scaling_governor 
write /sys/devices/system/cpu/cpufreq/policy4/scaling_governor 
write /sys/devices/system/cpu/cpufreq/policy7/scaling_governor 

write /sys/class/kgsl/kgsl-3d0/devfreq/gpu_governor 
write /sys/kernel/gpu/gpu_governor 
write /sys/class/devfreq/1d84000.ufshc/governor 
write /proc/sys/net/ipv4/tcp_congestion_control 