# Write To Files Functions
write() {
	# Command to skip if the file/value/parameters is not-found/unwritable
	[[ ! -f "$1" ]] && return 1

	# Make file writable if is possible
	chmod +w "$1" 2> /dev/null

	# Skip unwritable value/parameters and write new value/parameters
	if ! echo "$2" > "$1" 2> /dev/null
	then
		echo "Failed to Write: $1 → $2"
		return 1
	fi

	# Log the success
	echo "$1 → $2"
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

# CPU
for cpu in /sys/devices/system/cpu/*/cpufreq
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

# GPU
for gpu in /sys/kernel/kgsl/*/devfreq
do
	available_governors="$(cat "$gpu/available_governors")"
	for governor in
	do
		if [[ "$available_governors" == *"$governor"* ]]
		then
			write "$gpu/governor" "$governor"
			break
		fi
	done
done

for gpu in /sys/kernel/gpu
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
for queue in /sys/block/*/queue
do
	available_schedulers="$(cat "$queue/scheduler")"
	for sched in mq-deadline deadline kyber bfq cfq noop none
	do
		if [[ "$available_schedulers" == *"$sched"* ]]
		then
			write "$queue/scheduler" "$sched"
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