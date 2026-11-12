# Write to OS System/Device and Hardware Data Files
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
for cpu_dir in /sys/devices/system/cpu/cpufreq/policy* /sys/devices/system/cpu/cpu*/cpufreq; do
    [ -d "$cpu_dir" ] || continue
    avail_file="$cpu_dir/scaling_available_governors"
    gov_file="$cpu_dir/scaling_governor"
    [ -f "$avail_file" ] && [ -f "$gov_file" ] || continue
    available_governors="$(cat "$avail_file" 2>/dev/null)"
    for governor in performance; do
        case "$available_governors" in
            *"$governor"*)
                write "$gov_file" "$governor"
                break
                ;;
        esac
    done
done

for gpu_dir in /sys/class/kgsl/kgsl-3d0 /sys/class/devfreq/*gpu* /sys/devices/platform/*.gpu /sys/devices/soc/*.gpu; do
    [ -d "$gpu_dir" ] || continue
    for avail_file in "$gpu_dir/gpu_available_governor" "$gpu_dir/available_governors"; do
        [ -f "$avail_file" ] || continue
        gov_dir="$gpu_dir"
        [ -f "$gpu_dir/gpu_governor" ] && target_file="$gpu_dir/gpu_governor"
        [ -f "$gpu_dir/governor" ] && target_file="$gpu_dir/governor"
        available_governors="$(cat "$avail_file" 2>/dev/null)"
        for governor in performance; do
            case "$available_governors" in
                *"$governor"*)
                    write "$target_file" "$governor"
                    break 2
                    ;;
            esac
        done
    done
done

# 3. I/O SCHEDULERS
for dev_dir in /sys/block/*; do
    dev=$(basename "$dev_dir")
    case "$dev" in
        loop*|dm-*|zram*|ram*|sr*|md*) continue ;;
    esac
    queue="$dev_dir/queue"
    sched_file="$queue/scheduler"
    [ -f "$sched_file" ] || continue
    available_schedulers="$(cat "$sched_file" 2>/dev/null)"
    for sched in none mq-deadline bfq kyber deadline noop; do
        case "$available_schedulers" in
            *"[$sched]"*|*"$sched"*)
                write "$sched_file" "$sched"
                break
                ;;
        esac
    done
done

for ufshc in /sys/class/devfreq/*ufshc* /sys/devices/platform/*.ufshc /sys/class/devfreq/soc:qcom,ufshc*; do
    [ -d "$ufshc" ] || continue
    avail_file="$ufshc/available_governors"
    gov_file="$ufshc/governor"
    [ -f "$avail_file" ] && [ -f "$gov_file" ] || continue
    available_governors="$(cat "$avail_file" 2>/dev/null)"
    for governor in performance; do
        case "$available_governors" in
            *"$governor"*)
                write "$gov_file" "$governor"
                break
                ;;
        esac
    done
done

# TCP CONGESTION ALGORITHM
tcp_avail="/proc/sys/net/ipv4/tcp_available_congestion_control"
tcp_ctrl_file="/proc/sys/net/ipv4/tcp_congestion_control"
if [ -f "$tcp_avail" ] && [ -f "$tcp_ctrl_file" ]; then
    available_tcps="$(cat "$tcp_avail" 2>/dev/null)"
    for tcp_ctrl in bbr bbr2 cubic reno westwood; do
        case "$available_tcps" in
            *"$tcp_ctrl"*)
                write "$tcp_ctrl_file" "$tcp_ctrl"
                break
                ;;
        esac
    done
fi