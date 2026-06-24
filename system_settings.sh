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

# Sync Data
sync

# System Blurs Effects
wm disable-blur 0
settings put global disable_window_blurs 0

# System Screen Refresh Rate
settings put system peak_refresh_rate 0
settings put system min_refresh_rate 0
settings put system low_power_refresh_rate 0

# System Animation Scales
settings put global window_animation_scale 1.00
settings put global transition_animation_scale 1.00
settings put global animator_duration_scale 1.00

# System Settings
settings put global development_settings_enabled 0
settings put global adb_enabled 0
settings put global app_restriction_enabled false
settings put global settings_enable_monitor_phantom_procs disable

# Others
dumpsys deviceidle disable
"/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
"/system/bin/device_config set_sync_disabled_for_tests persistent"