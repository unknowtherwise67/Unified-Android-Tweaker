# Write to OS System/Device and Hardware Files
write() {
	[[ ! -f "$1" ]] && return 1
	chmod +w "$1" 2> /dev/null
	if ! echo "$2" > "$1" 2> /dev/null
	then
		return 1
	fi
}

# Sync Data
sync

# CPU and GPU
for cpu in /sys/*/system/cpu/cpu*/cpufreq/* /sys/*/system/cpu/cpufreq/policy*
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

for gpu in /sys/*/kgsl/kgsl-3d0/devfreq /sys/*/gpu/
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
	case "$dev" in
        loop*|dm-*|zram*|ram*|sr*|md*) continue ;;
    esac
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
	for tcp_ctrl in
	do
		if [[ "$available_tcps" == *"$tcp_ctrl"* ]]
		then
			write "$tcp/tcp_congestion_control" "$tcp_ctrl"
			break
		fi
	done
done