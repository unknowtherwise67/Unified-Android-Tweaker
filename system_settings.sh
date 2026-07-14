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

# System Blurs Effects
wm disable-blur 0
settings put global disable_window_blurs 0

# System Screen Refresh Rate
settings put system peak_refresh_rate 0
settings put system min_refresh_rate 0
settings put system user_refresh_rate 0
settings put system low_power_refresh_rate 0

# System Animation Scales
settings put global window_animation_scale 1.0
settings put global transition_animation_scale 1.0
settings put global animator_duration_scale 1.0

# System Settings
settings put global development_settings_enabled 0
settings put global adb_enabled 0
settings put global app_restriction_enabled 0
settings put secure location_providers_allowed +gps,network
settings put secure location_mode 3
settings put secure location_network_based_enabled 1
settings put global wifi_scan_always_enabled 1
settings put global bluetooth_scan_always_enabled 1
settings put global settings_enable_monitor_phantom_procs 0
settings put global low_power 0
settings put global low_power_sticky 0
settings put secure adaptive_battery_management_enabled 0
settings put global device_idle_constants "enabled=false"
settings put global app_standby_enabled 0
settings put global dynamic_power_savings_enabled 0
settings put global low_power_trigger_level 0
settings put global oppo_smart_low_power_set 0
settings put system oppo_super_power_saving_mode 0

# Others
dumpsys deviceidle disable
setprop persist.sys.gps.izat.main 1
/system/bin/device_config set_sync_disabled_for_tests persistent
/system/bin/device_config put activity_manager freeze_on_cached_enabled false
/system/bin/device_config put app_hibernation app_hibernation_enabled false
/system/bin/device_config put activity_manager bg_current_drain_auto_restrict_abusive_apps_enabled false
/system/bin/device_config put activity_manager max_cached_processes 128
/system/bin/device_config put activity_manager max_phantom_processes 2147483647
/system/bin/device_config put activity_manager short_fgs_timeout_duration 2147483647
/system/bin/device_config put activity_manager bg_current_drain_threshold_to_restricted 2147483647