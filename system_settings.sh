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

# System/Other Settings
settings put global wifi_scan_always_enabled 1
settings put global bluetooth_scan_always_enabled 1
settings put global settings_enable_monitor_phantom_procs 0
settings put global development_settings_enabled 0
settings put global adb_enabled 0
settings put global app_restriction_enabled 0
settings put secure location_providers_allowed +gps,network
settings put secure location_mode 3
settings put secure location_network_based_enabled 1
settings put global low_power 0
settings put global low_power_sticky 0
settings put secure adaptive_battery_management_enabled 0
settings put global device_idle_constants "enabled=false,inactive_to=2592000000,motion_inactive_to=2592000000,sensing_to=0,locating_to=0,location_accuracy=2000.0,motion_inactive_timeout=2592000000,idle_after_inactive_to=2592000000,idle_pending_to=2592000000,max_idle_pending_to=2592000000,idle_pending_factor=1.0,idle_to=2592000000,max_idle_to=2592000000,idle_factor=1.0,min_time_to_alarm=86400000,max_temp_app_whitelist_duration=86400000,mms_temp_app_whitelist_duration=86400000,sms_temp_app_whitelist_duration=86400000,notification_whitelist_duration=86400000,light_after_inactive_to=2592000000,light_pre_idle_to=2592000000,light_idle_to=2592000000,light_idle_factor=1.0,light_max_idle_to=2592000000,light_idle_maintenance_min_budget=86400000,light_idle_maintenance_max_budget=86400000,min_light_maintenance_time=86400000,min_deep_maintenance_time=86400000,quick_doze_delay_to=2592000000"
settings put global app_standby_enabled 0
settings put global dynamic_power_savings_enabled 0
settings put global low_power_trigger_level 0

settings put global device_idle_constants_watch "enabled=false,inactive_to=2592000000,motion_inactive_to=2592000000,idle_after_inactive_to=2592000000,idle_to=2592000000,max_idle_to=2592000000"
settings put global automatic_power_save_mode 0
settings put global dynamic_power_savings_disable_threshold 0
settings put global app_auto_restriction_enabled 0
settings put global forced_app_standby_enabled 0
settings put global forced_app_standby_for_small_battery_enabled 0
settings put global enable_app_hibernation 0
settings put global app_hibernation_enabled 0
settings put global unused_app_hibernation_enabled 0
settings put global permissions_hub_enabled 1
settings put global cached_apps_freezer_enabled 0
settings put global app_profiler_enabled 0
settings put global background_process_limit -1

dumpsys deviceidle unforce 2> /dev/null
dumpsys deviceidle enable all 2> /dev/null
dumpsys battery reset 2> /dev/null
dumpsys deviceidle disable

# Manufacturer/Brand Device Specific/Other Settings
settings put global adaptive_fast_charging 1
settings put global super_fast_charging 1
settings put global sem_low_power_mode 0
settings put global sem_power_mode 0
settings put global put_unused_apps_to_sleep 0
settings put secure put_unused_apps_to_sleep 0
settings put global deep_sleeping_apps_enabled 0
settings put global sleeping_apps_enabled 0
settings put global adaptive_battery_enabled 0
settings put global galaxy_sleep_mode_enabled 0
settings put system intelligent_sleep_mode 0
settings put system power_mode 0
settings put secure power_mode 0
settings put global power_mode 0
settings put system miui_power_save_mode 0
settings put global miui_power_save_mode 0
settings put secure miui_power_save_mode 0
settings put system extreme_power_mode 0
settings put global extreme_power_mode 0
settings put system battery_saver_mode 0
settings put global battery_saver_mode 0
settings put secure perf_mode 1
settings put system perf_mode 1
settings put global app_standby_mode 0
settings put secure app_standby_mode 0
settings put system smart_powersave_enable 0
settings put global smart_powersave_enable 0
settings put system background_limit_enable 0
settings put global background_limit_enable 0
settings put system miui_bg_kill_enable 0
settings put global miui_bg_kill_enable 0
settings put global oppodevice_battery_saving 0
settings put system oppodevice_battery_saving 0
settings put global coloros_battery_saving 0
settings put global sleep_standby_optimization 0
settings put secure sleep_standby_optimization 0
settings put global deep_sleep_optimization 0
settings put global app_freeze_enabled 0
settings put global oplus_app_freeze_enabled 0
settings put global oplus_bg_restrict_enabled 0
settings put global oneplus_bg_restrict_enabled 0
settings put global aggressive_doze_enabled 0
settings put global enhanced_battery_optimization 0
settings put global smart_power_saving_enabled 0
settings put global vivo_power_saving 0
settings put system vivo_power_saving 0
settings put global iqoo_power_saving 0
settings put global vivo_bg_freeze_enabled 0
settings put global vivo_high_power_consumption_reminder 0
settings put global vivo_auto_clean_bg_apps 0
settings put global origin_power_saving 0
settings put system SmartModeStatus 0
settings put global SmartModeStatus 0
settings put system huawei_power_saving 0
settings put global huawei_power_saving 0
settings put global honor_power_saving 0
settings put global magic_power_saving 0
settings put global app_launch_management_enabled 0
settings put global huawei_bg_restrict_enabled 0
settings put global stamina_mode 0
settings put system stamina_mode 0
settings put global ultra_stamina_mode 0
settings put global asus_power_saving 0
settings put global optiflex_enabled 0
settings put global nothing_power_saving 0
settings put global nothing_bg_restrict_enabled 0

settings put global game_mode_intervention 1
settings put system high_frame_rate_mode 1
settings put global high_refresh_rate_mode 1
settings put system high_refresh_rate_mode 1
settings put system thermal_limit_refresh_rate 0
settings put global thermal_limit_refresh_rate 0
settings put system performance_mode 0
settings put global performance_mode 0
settings put secure performance_mode 0
settings put global high_performance_mode 0
settings put system high_performance_mode 0
settings put global sem_performance_mode 0
settings put system sem_performance_mode 0
settings put secure perf_mode 0
settings put system perf_mode 0
settings put global perf_mode 0
settings put global high_performance_mode_enabled 0
settings put system high_performance_mode_enabled 0
settings put global oplus_performance_mode 0
settings put global gt_mode_enabled 0
settings put global vivo_performance_mode 0
settings put global iqoo_monster_mode 0
settings put global huawei_performance_mode 0
settings put global honor_performance_mode 0
settings put global magic_performance_mode 0
settings put global asus_performance_mode 0
settings put global nothing_performance_mode 0