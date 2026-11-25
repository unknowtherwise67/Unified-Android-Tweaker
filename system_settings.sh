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