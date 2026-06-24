# Write to OS System/Device Data Files
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

# System Files Permissions
chmod 666 /sys/devices/system/cpu/cpu0/online
chmod 666 /sys/devices/system/cpu/cpu1/online
chmod 666 /sys/devices/system/cpu/cpu2/online
chmod 666 /sys/devices/system/cpu/cpu3/online
chmod 666 /sys/devices/system/cpu/cpu4/online
chmod 666 /sys/devices/system/cpu/cpu5/online
chmod 666 /sys/devices/system/cpu/cpu6/online
chmod 666 /sys/devices/system/cpu/cpu7/online
chmod 666 /sys/devices/system/cpu/cpu8/online
chmod 666 /sys/devices/system/cpu/cpu9/online
chmod 666 /sys/devices/system/cpu/cpu10/online
chmod 666 /sys/devices/system/cpu/cpu11/online

chmod 666 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu8/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu9/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu10/cpufreq/scaling_governor
chmod 666 /sys/devices/system/cpu/cpu11/cpufreq/scaling_governor

chmod 666 /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
chmod 666 /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
chmod 666 /sys/devices/system/cpu/cpufreq/policy7/scaling_governor

chmod 666 /sys/class/kgsl/kgsl-3d0/devfreq/gpu_governor
chmod 666 /sys/kernel/gpu/gpu_governor
chmod 666 /sys/class/devfreq/1d84000.ufshc/governor
chmod 666 /proc/sys/net/ipv4/tcp_congestion_control

chmod 666 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu8/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu9/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu10/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu11/cpufreq/scaling_max_freq

chmod 666 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu8/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu9/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu10/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu11/cpufreq/scaling_min_freq

chmod 666 /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq

chmod 666 /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq

chmod 666 /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
chmod 666 /sys/class/kgsl/kgsl-3d0/devfreq/min_freq

chmod 666 /sys/class/power_supply/battery/constant_charge_current_max