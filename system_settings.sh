# Write To Files Functions
write() {
	# Command to skip if the file/value/parameters is not-found/unwritable
	[[ ! -f "$1" ]] && return 1

	# Make file writable if is possible
	chmod +w "$1" 2> /dev/null

	# Skip unwritable value/parameters and write new value/parameters
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

# System Settings
wm disable-blur 0
settings put global disable_window_blurs 0

settings put system peak_refresh_rate 0
settings put system min_refresh_rate 0
settings put system low_power_refresh_rate 0

settings put global window_animation_scale 1.00
settings put global transition_animation_scale 1.00
settings put global animator_duration_scale 1.00

settings put global wifi_scan_always_enabled 1
settings put global ble_scan_always_enabled 1
settings put global settings_enable_monitor_phantom_procs disable

# Others
dumpsys deviceidle disable