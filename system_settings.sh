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

wm disable-blur 0
settings put global disable_window_blurs 0
settings put system screen_brightness_mode 0
settings put system peak_refresh_rate 0
settings put system min_refresh_rate 0
settings put system low_power_refresh_rate 0
settings put global development_settings_enabled 0
settings put global adb_enabled 0
settings put global window_animation_scale 1.00
settings put global transition_animation_scale 1.00
settings put global animator_duration_scale 1.00
settings put global wifi_scan_always_enabled 0
settings put global ble_scan_always_enabled 0
settings put global adaptive_battery_management_enabled 0
settings put global tether_offload_disabled 0
settings put global wifi_power_save 0
settings put global network_scoring_ui_enabled 0
settings put global cached_apps_freezer disabled 0
settings put secure adaptive_sleep 0
settings put global dynamic_power_savings_enabled 0
settings put global automatic_power_save_mode 0
settings put global app_standby_enabled 0
settings put secure screensaver_activate_on_sleep 0
settings put secure screensaver_enabled 0
settings put global network_recommendations_enabled 0
settings put secure bluetooth_a2dp_bt_uhq_state 1
settings put secure bluetooh_a2dp_uhqa_support 1
settings put system tube_amp_effect 1
settings put system k2hd_effect 1
settings put secure tap_duration_threshold 0.0
settings put secure touch_blocking_period 0.0
settings put global settings_enable_monitor_phantom_procs disable
setprop persist.sys.fflag.override.settings_enable_monitor_phantom_procs disable
dumpsys deviceidle disable

# Thermal/HotPlug/Processor Controls
stop thermal
setprop ctl.stop mpdecision;stop mpdecision
write /sys/module/msm_thermal/core_control/enabled 0
write /sys/module/msm_thermal/vdd_restriction/enabled 0