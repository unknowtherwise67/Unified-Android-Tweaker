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

# System Blurs Effects
wm disable-blur 0
settings put global disable_window_blurs 0

# System Screen Rotations
settings put system accelerometer_rotation
settings put system user_rotation

# System Screen Refresh Rate
settings put system peak_refresh_rate 0
settings put system min_refresh_rate 0
settings put system low_power_refresh_rate 0

# System Animations
settings put global window_animation_scale 1.00
settings put global transition_animation_scale 1.00
settings put global animator_duration_scale 1.00

# System Settings
settings put system screen_brightness_mode 0
settings put system intelligent_sleep_mode 0
settings put global development_settings_enabled 0
settings put global adb_enabled 0
settings put global enhanced_processing 1
settings put global wifi_scan_always_enabled 1
settings put global ble_scan_always_enabled 1
settings put global wifi_scan_throttle_enabled 0
settings put global wifi_power_save 0
settings put global network_restricted_mode 0
settings put global network_scoring_ui_enabled 0
settings put global network_recommendations_enabled 1
settings put global sem_enhanced_cpu_responsiveness 1
settings put global dynamic_power_savings_disable_threshold 1
settings put global adaptive_battery_management_enabled 0
settings put global accessibility_reduce_transparency 0
settings put global cached_apps_freezer disabled 0
settings put global dynamic_power_savings_enabled 0
settings put global automatic_power_save_mode 0
settings put global app_standby_enabled 0
settings put global app_restriction_enabled false
settings put global settings_enable_monitor_phantom_procs disable
settings put secure location_mode 3
settings put secure bluetooth_a2dp_bt_uhq_state 1
settings put secure bluetooh_a2dp_uhqa_support 1
settings put secure tap_duration_threshold 0.0
settings put secure touch_blocking_period 0.0
settings put secure screensaver_activate_on_sleep 0
settings put secure screensaver_enabled 0
settings put secure adaptive_sleep 0

# System/Hardware Offload
settings put global tether_offload_disabled 0
settings put global bluetooth_a2dp_offload_disabled 0

# Others
dumpsys deviceidle disable
write /sys/module/msm_thermal/core_control/enabled 0
write /sys/module/msm_thermal/vdd_restriction/enabled 0

# CPU
for cpu in /sys/devices/system/cpu/cpufreq/policy0
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

for cpu in /sys/devices/system/cpu/cpufreq/policy4
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

for cpu in /sys/devices/system/cpu/cpufreq/policy7
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
for gpu in /sys/kernel/kgsl/kgsl-3d0/devfreq
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

# Schedulers
write /proc/sys/kernel/sched_latency_ns 1000000
write /proc/sys/kernel/sched_migration_cost_ns 1000000
write /proc/sys/kernel/sched_min_granularity_ns 1000000
write /proc/sys/kernel/sched_wakeup_granularity_ns 1000000
write /proc/sys/kernel/sched_coloc_busy_hyst_ns 1000000
write /proc/sys/kernel/sched_short_burst_ns 1000000
write /proc/sys/kernel/sched_short_sleep_ns 1000000
write /proc/sys/kernel/sched_shares_window_ns 1000000
write /proc/sys/kernel/sched_nr_migrate 1000000
write /proc/sys/kernel/sched_rr_timeslice_us 1000000
write /proc/sys/kernel/sched_deadline_period_max_us 1000000
write /proc/sys/kernel/sched_deadline_period_min_us 1000000
write /proc/sys/kernel/sched_walt_cpu_high_irqload 1000000
write /proc/sys/kernel/sched_shares_window 1000000
write /proc/sys/kernel/sched_freq_aggregate_threshold 1000000
write /proc/sys/kernel/sched_freq_dec_notify 1000000
write /proc/sys/kernel/sched_freq_inc_notify 1000000
write /proc/sys/kernel/sched_pred_alert_freq 1000000
write /proc/sys/kernel/sched_rr_timeslice_ms 1000000
write /proc/sys/kernel/sched_time_avg_ms 1000000
write /proc/sys/kernel/sched_select_prev_cpu_us 1000000
write /proc/sys/kernel/sched_time_avg 1000000
write /proc/sys/kernel/sched_task_unfilter_period 1000000
write /proc/sys/kernel/sched_rt_period_us 1000000
write /proc/sys/kernel/sched_rt_runtime_us 1000000
write /proc/sys/kernel/sched_group_upmigrate 1000000
write /proc/sys/kernel/sched_group_downmigrate 1000000
write /proc/sys/kernel/sched_upmigrate 1000000
write /proc/sys/kernel/sched_downmigrate 1000000
write /proc/sys/kernel/sched_coloc_busy_hyst_max_ms 1000000
write /proc/sys/kernel/sched_freq_aggregate_threshold 1000000
write /proc/sys/kernel/sched_many_wakeup_threshold 1000000
write /proc/sys/kernel/sched_util_clamp_max 1024
write /proc/sys/kernel/sched_util_clamp_min 1024
write /proc/sys/kernel/sched_util_clamp_min_rt_default 1024
write /proc/sys/kernel/sched_coloc_busy_hysteresis_enable_cpus 1024
write /proc/sys/kernel/sched_asym_cap_sibling_freq_match_pct 1024
write /proc/sys/kernel/sched_walt_init_task_load_pct 1024
write /proc/sys/kernel/sched_init_task_load 1024
write /proc/sys/kernel/sched_spill_load 1024
write /proc/sys/kernel/sched_min_task_util_for_colocation 1024
write /proc/sys/kernel/sched_min_task_util_for_boost 1024
write /proc/sys/kernel/sched_big_waker_task_load 1024
write /proc/sys/kernel/sched_small_wakee_task_load 1024
write /proc/sys/kernel/sched_stune_task_threshold 100
write /proc/sys/kernel/sched_pelt_multiplier 4
write /proc/sys/kernel/perf_cpu_time_max_percent 1
write /proc/sys/kernel/sched_schedstats 1
write /proc/sys/kernel/sched_tunable_scaling 0
write /proc/sys/kernel/sched_child_runs_first 0
write /proc/sys/kernel/sched_autogroup_enabled 0
write /proc/sys/kernel/sched_energy_aware 0

write /sys/kernel/debug/sched/sched_latency_ns 1000000
write /sys/kernel/debug/sched/sched_migration_cost_ns 1000000
write /sys/kernel/debug/sched/sched_min_granularity_ns 1000000
write /sys/kernel/debug/sched/sched_wakeup_granularity_ns 1000000
write /sys/kernel/debug/sched/sched_coloc_busy_hyst_ns 1000000
write /sys/kernel/debug/sched/sched_short_burst_ns 1000000
write /sys/kernel/debug/sched/sched_short_sleep_ns 1000000
write /sys/kernel/debug/sched/sched_shares_window_ns 1000000
write /sys/kernel/debug/sched/sched_nr_migrate 1000000
write /sys/kernel/debug/sched/sched_rr_timeslice_us 1000000
write /sys/kernel/debug/sched/sched_deadline_period_max_us 1000000
write /sys/kernel/debug/sched/sched_deadline_period_min_us 1000000
write /sys/kernel/debug/sched/sched_walt_cpu_high_irqload 1000000
write /sys/kernel/debug/sched/sched_shares_window 1000000
write /sys/kernel/debug/sched/sched_freq_aggregate_threshold 1000000
write /sys/kernel/debug/sched/sched_freq_dec_notify 1000000
write /sys/kernel/debug/sched/sched_freq_inc_notify 1000000
write /sys/kernel/debug/sched/sched_pred_alert_freq 1000000
write /sys/kernel/debug/sched/sched_rr_timeslice_ms 1000000
write /sys/kernel/debug/sched/sched_time_avg_ms 1000000
write /sys/kernel/debug/sched/sched_select_prev_cpu_us 1000000
write /sys/kernel/debug/sched/sched_time_avg 1000000
write /sys/kernel/debug/sched/sched_task_unfilter_period 1000000
write /sys/kernel/debug/sched/sched_rt_period_us 1000000
write /sys/kernel/debug/sched/sched_rt_runtime_us 1000000
write /sys/kernel/debug/sched/sched_group_upmigrate 1000000
write /sys/kernel/debug/sched/sched_group_downmigrate 1000000
write /sys/kernel/debug/sched/sched_upmigrate 1000000
write /sys/kernel/debug/sched/sched_downmigrate 1000000
write /sys/kernel/debug/sched/sched_coloc_busy_hyst_max_ms 1000000
write /sys/kernel/debug/sched/sched_freq_aggregate_threshold 1000000
write /sys/kernel/debug/sched/sched_many_wakeup_threshold 1000000
write /sys/kernel/debug/sched/sched_util_clamp_max 1024
write /sys/kernel/debug/sched/sched_util_clamp_min 1024
write /sys/kernel/debug/sched/sched_util_clamp_min_rt_default 1024
write /sys/kernel/debug/sched/sched_coloc_busy_hysteresis_enable_cpus 1024
write /sys/kernel/debug/sched/sched_asym_cap_sibling_freq_match_pct 1024
write /sys/kernel/debug/sched/sched_walt_init_task_load_pct 1024
write /sys/kernel/debug/sched/sched_init_task_load 1024
write /sys/kernel/debug/sched/sched_spill_load 1024
write /sys/kernel/debug/sched/sched_min_task_util_for_colocation 1024
write /sys/kernel/debug/sched/sched_min_task_util_for_boost 1024
write /sys/kernel/debug/sched/sched_big_waker_task_load 1024
write /sys/kernel/debug/sched/sched_small_wakee_task_load 1024
write /sys/kernel/debug/sched/sched_stune_task_threshold 100
write /sys/kernel/debug/sched/sched_pelt_multiplier 4
write /sys/kernel/debug/sched/perf_cpu_time_max_percent 1
write /sys/kernel/debug/sched/sched_schedstats 1
write /sys/kernel/debug/sched/sched_tunable_scaling 0
write /sys/kernel/debug/sched/sched_child_runs_first 0
write /sys/kernel/debug/sched/sched_autogroup_enabled 0
write /sys/kernel/debug/sched/sched_energy_aware 0

write /sys/kernel/debug/sched_features NO_GENTLE_FAIR_SLEEPERS
write /sys/kernel/debug/sched_features NO_HRTICK
write /sys/kernel/debug/sched_features NO_DOUBLE_TICK
write /sys/kernel/debug/sched_features NO_RT_RUNTIME_SHARE
write /sys/kernel/debug/sched_features NO_NEXT_BUDDY
write /sys/kernel/debug/sched_features NO_LAST_BUDDY
write /sys/kernel/debug/sched_features NO_TTWU_QUEUE
write /sys/kernel/debug/sched_features NO_UTIL_EST
write /sys/kernel/debug/sched_features NO_ARCH_CAPACITY
write /sys/kernel/debug/sched_features NO_ARCH_POWER
write /sys/kernel/debug/sched_features NO_START_DEBIT
write /sys/kernel/debug/sched_features NO_CACHE_HOT_BUDDY
write /sys/kernel/debug/sched_features NO_WAKEUP_PREEMPTION
write /sys/kernel/debug/sched_features NO_LB_BIAS
write /sys/kernel/debug/sched_features NO_NONTASK_CAPACITY
write /sys/kernel/debug/sched_features NO_RT_PUSH_IPI
write /sys/kernel/debug/sched_features NO_FORCE_SD_OVERLAP
write /sys/kernel/debug/sched_features NO_LB_MIN
write /sys/kernel/debug/sched_features NO_ATTACH_AGE_LOAD
write /sys/kernel/debug/sched_features NO_SIS_AVG_CPU
write /sys/kernel/debug/sched_features NO_MIN_CAPACITY_CAPPING
write /sys/kernel/debug/sched_features NO_FBT_STRICT_ORDER
write /sys/kernel/debug/sched_features NO_EAS_USE_NEED_IDLE
write /sys/kernel/debug/sched_features NO_ENERGY_AWARE
write /sys/kernel/debug/sched_features NO_SCHED_HMP
write /sys/kernel/debug/sched_features NO_SCHED_MTK_EAS

# Schedtune Idles/Boosts/CPUs-Set
write /proc/sys/kernel/sched_cfs_boost 1
write /dev/stune/sched_cfs_boost 1
write /dev/stune/background/sched_cfs_boost 1
write /dev/stune/foreground/sched_cfs_boost 1
write /dev/stune/camera-daemon/sched_cfs_boost 1
write /dev/stune/system-background/sched_cfs_boost 1
write /dev/stune/nnapi-hal/sched_cfs_boost 1
write /dev/stune/rt/sched_cfs_boost 1
write /dev/stune/application/sched_cfs_boost 1
write /dev/stune/kernel/sched_cfs_boost 1
write /dev/stune/restricted/sched_cfs_boost 1
write /dev/stune/top-app/sched_cfs_boost 1
write /dev/stune/audio-app/sched_cfs_boost 1
write /dev/stune/h-background/sched_cfs_boost 1
write /dev/stune/l-background/sched_cfs_boost 1
write /dev/stune/display/sched_cfs_boost 1
write /dev/stune/oiface_fg/sched_cfs_boost 1
write /dev/stune/dex2oat/sched_cfs_boost 1
write /dev/stune/foreground_window/sched_cfs_boost 1
write /dev/stune/system/sched_cfs_boost 1

write /dev/stune/schedtune.colocate 1
write /dev/stune/background/schedtune.colocate 1
write /dev/stune/foreground/schedtune.colocate 1
write /dev/stune/camera-daemon/schedtune.colocate 1
write /dev/stune/system-background/schedtune.colocate 1
write /dev/stune/rt/schedtune.colocate 1
write /dev/stune/nnapi-hal/schedtune.colocate 1
write /dev/stune/application/schedtune.colocate 1
write /dev/stune/kernel/schedtune.colocate 1
write /dev/stune/restricted/schedtune.colocate 1
write /dev/stune/top-app/schedtune.colocate 1
write /dev/stune/audio-app/schedtune.colocate 1
write /dev/stune/h-background/schedtune.colocate 1
write /dev/stune/l-background/schedtune.colocate 1
write /dev/stune/display/schedtune.colocate 1
write /dev/stune/oiface_fg/schedtune.colocate 1
write /dev/stune/sf/schedtune.colocate 1
write /dev/stune/dex2oat/schedtune.colocate 1
write /dev/stune/foreground_window/schedtune.colocate 1
write /dev/stune/system/schedtune.colocate 1

write /dev/stune/schedtune.sched_boost_enabled 1
write /dev/stune/background/schedtune.sched_boost_enabled 1
write /dev/stune/foreground/schedtune.sched_boost_enabled 1
write /dev/stune/camera-daemon/schedtune.sched_boost_enabled 1
write /dev/stune/system-background/schedtune.sched_boost_enabled 1
write /dev/stune/rt/schedtune.sched_boost_enabled 1
write /dev/stune/nnapi-hal/schedtune.sched_boost_enabled 1
write /dev/stune/application/schedtune.sched_boost_enabled 1
write /dev/stune/kernel/schedtune.sched_boost_enabled 1
write /dev/stune/restricted/schedtune.sched_boost_enabled 1
write /dev/stune/top-app/schedtune.sched_boost_enabled 1
write /dev/stune/audio-app/schedtune.sched_boost_enabled 1
write /dev/stune/h-background/schedtune.sched_boost_enabled 1
write /dev/stune/l-background/schedtune.sched_boost_enabled 1
write /dev/stune/display/schedtune.sched_boost_enabled 1
write /dev/stune/oiface_fg/schedtune.sched_boost_enabled 1
write /dev/stune/sf/schedtune.sched_boost_enabled 1
write /dev/stune/dex2oat/schedtune.sched_boost_enabled 1
write /dev/stune/foreground_window/schedtune.sched_boost_enabled 1
write /dev/stune/system/schedtune.sched_boost_enabled 1

write /dev/stune/schedtune.prefer_high_cap 1
write /dev/stune/background/schedtune.prefer_high_cap 1
write /dev/stune/foreground/schedtune.prefer_high_cap 1
write /dev/stune/camera-daemon/schedtune.prefer_high_cap 1
write /dev/stune/system-background/schedtune.prefer_high_cap 1
write /dev/stune/rt/schedtune.prefer_high_cap 1
write /dev/stune/nnapi-hal/schedtune.prefer_high_cap 1
write /dev/stune/application/schedtune.prefer_high_cap 1
write /dev/stune/kernel/schedtune.prefer_high_cap 1
write /dev/stune/restricted/schedtune.prefer_high_cap 1
write /dev/stune/top-app/schedtune.prefer_high_cap 1
write /dev/stune/audio-app/schedtune.prefer_high_cap 1
write /dev/stune/h-background/schedtune.prefer_high_cap 1
write /dev/stune/l-background/schedtune.prefer_high_cap 1
write /dev/stune/display/schedtune.prefer_high_cap 1
write /dev/stune/oiface_fg/schedtune.prefer_high_cap 1
write /dev/stune/sf/schedtune.prefer_high_cap 1
write /dev/stune/dex2oat/schedtune.prefer_high_cap 1
write /dev/stune/foreground_window/schedtune.prefer_high_cap 1
write /dev/stune/system/schedtune.prefer_high_cap 1

write /dev/stune/schedtune.prefer_idle 1
write /dev/stune/background/schedtune.prefer_idle 1
write /dev/stune/foreground/schedtune.prefer_idle 1
write /dev/stune/rt/schedtune.prefer_idle 1
write /dev/stune/application/schedtune.prefer_idle 1
write /dev/stune/kernel/schedtune.prefer_idle 1
write /dev/stune/restricted/schedtune.prefer_idle 1
write /dev/stune/camera-daemon/schedtune.prefer_idle 1
write /dev/stune/nnapi-hal/schedtune.prefer_idle 1
write /dev/stune/system-background/schedtune.prefer_idle 1
write /dev/stune/top-app/schedtune.prefer_idle 1
write /dev/stune/audio/schedtune.prefer_idle 1
write /dev/stune/h-background/schedtune.prefer_idle 1
write /dev/stune/l-background/schedtune.prefer_idle 1
write /dev/stune/display/schedtune.prefer_idle 1
write /dev/stune/oiface_fg/schedtune.prefer_idle 1
write /dev/stune/sf/schedtune.prefer_idle 1
write /dev/stune/dex2oat/schedtune.prefer_idle 1
write /dev/stune/foreground_window/schedtune.prefer_idle 1
write /dev/stune/system/schedtune.prefer_idle 1

write /dev/cpuctl/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/background/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/foreground/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/rt/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/application/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/kernel/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/restricted/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/camera-daemon/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/nnapi-hal/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/system-background/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/top-app/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/audio/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/h-background/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/l-background/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/display/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/oiface_fg/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/sf/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/dex2oat/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/foreground_window/cpu.uclamp.latency_sensitive 1
write /dev/cpuctl/system/cpu.uclamp.latency_sensitive 1

write /dev/stune/cpu.uclamp.latency_sensitive 1
write /dev/stune/background/cpu.uclamp.latency_sensitive 1
write /dev/stune/foreground/cpu.uclamp.latency_sensitive 1
write /dev/stune/rt/cpu.uclamp.latency_sensitive 1
write /dev/stune/application/cpu.uclamp.latency_sensitive 1
write /dev/stune/kernel/cpu.uclamp.latency_sensitive 1
write /dev/stune/restricted/cpu.uclamp.latency_sensitive 1
write /dev/stune/camera-daemon/cpu.uclamp.latency_sensitive 1
write /dev/stune/nnapi-hal/cpu.uclamp.latency_sensitive 1
write /dev/stune/system-background/cpu.uclamp.latency_sensitive 1
write /dev/stune/top-app/cpu.uclamp.latency_sensitive 1
write /dev/stune/audio/cpu.uclamp.latency_sensitive 1
write /dev/stune/h-background/cpu.uclamp.latency_sensitive 1
write /dev/stune/l-background/cpu.uclamp.latency_sensitive 1
write /dev/stune/display/cpu.uclamp.latency_sensitive 1
write /dev/stune/oiface_fg/cpu.uclamp.latency_sensitive 1
write /dev/stune/sf/cpu.uclamp.latency_sensitive 1
write /dev/stune/dex2oat/cpu.uclamp.latency_sensitive 1
write /dev/stune/foreground_window/cpu.uclamp.latency_sensitive 1
write /dev/stune/system/cpu.uclamp.latency_sensitive 1

write /dev/stune/schedtune.sched_boost_no_override 1
write /dev/stune/background/schedtune.sched_boost_no_override 1
write /dev/stune/foreground/schedtune.sched_boost_no_override 1
write /dev/stune/camera-daemon/schedtune.sched_boost_no_override 1
write /dev/stune/system-background/schedtune.sched_boost_no_override 1
write /dev/stune/nnapi-hal/schedtune.sched_boost_no_override 1
write /dev/stune/application/schedtune.sched_boost_no_override 1
write /dev/stune/kernel/schedtune.sched_boost_no_override 1
write /dev/stune/restricted/schedtune.sched_boost_no_override 1
write /dev/stune/top-app/schedtune.sched_boost_no_override 1
write /dev/stune/audio-app/schedtune.sched_boost_no_override 1
write /dev/stune/h-background/schedtune.sched_boost_no_override 1
write /dev/stune/l-background/schedtune.sched_boost_no_override 1
write /dev/stune/display/schedtune.sched_boost_no_override 1
write /dev/stune/oiface_fg/schedtune.sched_boost_no_override 1
write /dev/stune/sf/schedtune.sched_boost_no_override 1
write /dev/stune/dex2oat/schedtune.sched_boost_no_override 1
write /dev/stune/foreground_window/schedtune.sched_boost_no_override 1
write /dev/stune/system/schedtune.sched_boost_no_override 1

write /dev/stune/schedtune.cpucapacity_min max
write /dev/stune/background/schedtune.cpucapacity_min max
write /dev/stune/foreground/schedtune.cpucapacity_min max
write /dev/stune/camera-daemon/schedtune.cpucapacity_min max
write /dev/stune/system-background/schedtune.cpucapacity_min max
write /dev/stune/nnapi-hal/schedtune.cpucapacity_min max
write /dev/stune/application/schedtune.cpucapacity_min max
write /dev/stune/kernel/schedtune.cpucapacity_min max
write /dev/stune/restricted/schedtune.cpucapacity_min max
write /dev/stune/top-app/schedtune.cpucapacity_min max
write /dev/stune/audio-app/schedtune.cpucapacity_min max
write /dev/stune/h-background/schedtune.cpucapacity_min max
write /dev/stune/l-background/schedtune.cpucapacity_min max
write /dev/stune/display/schedtune.cpucapacity_min max
write /dev/stune/oiface_fg/schedtune.cpucapacity_min max
write /dev/stune/sf/schedtune.cpucapacity_min max
write /dev/stune/dex2oat/schedtune.cpucapacity_min max
write /dev/stune/foreground_window/schedtune.cpucapacity_min max
write /dev/stune/system/schedtune.cpucapacity_min max

write /dev/stune/background/schedtune.uclamp.max max
write /dev/stune/foreground/schedtune.uclamp.max max
write /dev/stune/camera-daemon/schedtune.uclamp.max max
write /dev/stune/system-background/schedtune.uclamp.max max
write /dev/stune/nnapi-hal/schedtune.uclamp.max max
write /dev/stune/rt/schedtune.uclamp.max max
write /dev/stune/application/schedtune.uclamp.max max
write /dev/stune/kernel/schedtune.uclamp.max max
write /dev/stune/restricted/schedtune.uclamp.max max
write /dev/stune/top-app/schedtune.uclamp.max max
write /dev/stune/audio-app/schedtune.uclamp.max max
write /dev/stune/h-background/schedtune.uclamp.max max
write /dev/stune/l-background/schedtune.uclamp.max max
write /dev/stune/display/schedtune.uclamp.max max
write /dev/stune/oiface_fg/schedtune.uclamp.max max
write /dev/stune/sf/schedtune.uclamp.max max
write /dev/stune/dex2oat/schedtune.uclamp.max max
write /dev/stune/foreground_window/schedtune.uclamp.max max
write /dev/stune/system/schedtune.uclamp.max max

write /dev/stune/background/schedtune.uclamp.max.effective max
write /dev/stune/foreground/schedtune.uclamp.max.effective max
write /dev/stune/camera-daemon/schedtune.uclamp.max.effective max
write /dev/stune/system-background/schedtune.uclamp.max.effective max
write /dev/stune/nnapi-hal/schedtune.uclamp.max.effective max
write /dev/stune/rt/schedtune.uclamp.max.effective max
write /dev/stune/application/schedtune.uclamp.max.effective max
write /dev/stune/kernel/schedtune.uclamp.max.effective max
write /dev/stune/restricted/schedtune.uclamp.max.effective max
write /dev/stune/top-app/schedtune.uclamp.max max.effective max
write /dev/stune/audio-app/schedtune.uclamp.max.effective max
write /dev/stune/h-background/schedtune.uclamp.max.effective max
write /dev/stune/l-background/schedtune.uclamp.max.effective max
write /dev/stune/display/schedtune.uclamp.max.effective max
write /dev/stune/oiface_fg/schedtune.uclamp.max.effective max
write /dev/stune/sf/schedtune.uclamp.max.effective max
write /dev/stune/dex2oat/schedtune.uclamp.max.effective max
write /dev/stune/foreground_window/schedtune.uclamp.max.effective max
write /dev/stune/system/schedtune.uclamp.max.effective max

write /dev/stune/background/schedtune.uclamp.min max
write /dev/stune/foreground/schedtune.uclamp.min max
write /dev/stune/camera-daemon/schedtune.uclamp.min max
write /dev/stune/system-background/schedtune.uclamp.min max
write /dev/stune/nnapi-hal/schedtune.uclamp.min max
write /dev/stune/rt/schedtune.uclamp.min max
write /dev/stune/application/schedtune.uclamp.min max
write /dev/stune/kernel/schedtune.uclamp.min max
write /dev/stune/restricted/schedtune.uclamp.min max
write /dev/stune/top-app/schedtune.uclamp.min max
write /dev/stune/audio-app/schedtune.uclamp.min max
write /dev/stune/h-background/schedtune.uclamp.min max
write /dev/stune/l-background/schedtune.uclamp.min max
write /dev/stune/display/schedtune.uclamp.min max
write /dev/stune/oiface_fg/schedtune.uclamp.min max
write /dev/stune/sf/schedtune.uclamp.min max
write /dev/stune/dex2oat/schedtune.uclamp.min max
write /dev/stune/foreground_window/schedtune.uclamp.min max
write /dev/stune/system/schedtune.uclamp.min max

write /dev/stune/background/schedtune.uclamp.min.effective max
write /dev/stune/foreground/schedtune.uclamp.min.effective max
write /dev/stune/camera-daemon/schedtune.uclamp.min.effective max
write /dev/stune/system-background/schedtune.uclamp.min.effective max
write /dev/stune/nnapi-hal/schedtune.uclamp.min.effective max
write /dev/stune/rt/schedtune.uclamp.min.effective max
write /dev/stune/application/schedtune.uclamp.min.effective max
write /dev/stune/kernel/schedtune.uclamp.min.effective max
write /dev/stune/restricted/schedtune.uclamp.min.effective max
write /dev/stune/top-app/schedtune.uclamp.min.effective max
write /dev/stune/audio-app/schedtune.uclamp.min.effective max
write /dev/stune/h-background/schedtune.uclamp.min.effective max
write /dev/stune/l-background/schedtune.uclamp.min.effective max
write /dev/stune/display/schedtune.uclamp.min.effective max
write /dev/stune/oiface_fg/schedtune.uclamp.min.effective max
write /dev/stune/sf/schedtune.uclamp.min.effective max
write /dev/stune/dex2oat/schedtune.uclamp.min.effective max
write /dev/stune/foreground_window/schedtune.uclamp.min.effective max
write /dev/stune/system/schedtune.uclamp.min.effective max

write /dev/cpuctl/cpu.cpucapacity_min max
write /dev/cpuctl/background/cpu.cpucapacity_min max
write /dev/cpuctl/foreground/cpu.cpucapacity_min max
write /dev/cpuctl/camera-daemon/cpu.cpucapacity_min max
write /dev/cpuctl/system-background/cpu.cpucapacity_min max
write /dev/cpuctl/nnapi-hal/cpu.cpucapacity_min max
write /dev/cpuctl/application/cpu.cpucapacity_min max
write /dev/cpuctl/kernel/cpu.cpucapacity_min max
write /dev/cpuctl/restricted/cpu.cpucapacity_min max
write /dev/cpuctl/top-app/cpu.cpucapacity_min max
write /dev/cpuctl/audio-app/cpu.cpucapacity_min max
write /dev/cpuctl/h-background/cpu.cpucapacity_min max
write /dev/cpuctl/l-background/cpu.cpucapacity_min max
write /dev/cpuctl/display/cpu.cpucapacity_min max
write /dev/cpuctl/oiface_fg/cpu.cpucapacity_min max
write /dev/cpuctl/sf/cpu.cpucapacity_min max
write /dev/cpuctl/dex2oat/cpu.cpucapacity_min max
write /dev/cpuctl/foreground_window/cpu.cpucapacity_min max
write /dev/cpuctl/system/cpu.cpucapacity_min max

write /dev/cpuctl/background/cpu.uclamp.max max
write /dev/cpuctl/foreground/cpu.uclamp.max max
write /dev/cpuctl/camera-daemon/cpu.uclamp.max max
write /dev/cpuctl/system-background/cpu.uclamp.max max
write /dev/cpuctl/nnapi-hal/cpu.uclamp.max max
write /dev/cpuctl/rt/cpu.uclamp.max max
write /dev/cpuctl/application/cpu.uclamp.max max
write /dev/cpuctl/kernel/cpu.uclamp.max max
write /dev/cpuctl/restricted/cpu.uclamp.max max
write /dev/cpuctl/top-app/cpu.uclamp.max max
write /dev/cpuctl/audio-app/cpu.uclamp.max max
write /dev/cpuctl/h-background/cpu.uclamp.max max
write /dev/cpuctl/l-background/cpu.uclamp.max max
write /dev/cpuctl/display/cpu.uclamp.max max
write /dev/cpuctl/oiface_fg/cpu.uclamp.max max
write /dev/cpuctl/sf/cpu.uclamp.max max
write /dev/cpuctl/dex2oat/cpu.uclamp.max max
write /dev/cpuctl/foreground_window/cpu.uclamp.max max
write /dev/cpuctl/system/cpu.uclamp.max max

write /dev/cpuctl/background/cpu.uclamp.max.effective max
write /dev/cpuctl/foreground/cpu.uclamp.max.effective max
write /dev/cpuctl/camera-daemon/cpu.uclamp.max.effective max
write /dev/cpuctl/system-background/cpu.uclamp.max.effective max
write /dev/cpuctl/nnapi-hal/cpu.uclamp.max.effective max
write /dev/cpuctl/rt/cpu.uclamp.max.effective max
write /dev/cpuctl/application/cpu.uclamp.max.effective max
write /dev/cpuctl/kernel/cpu.uclamp.max.effective max
write /dev/cpuctl/restricted/cpu.uclamp.max.effective max
write /dev/cpuctl/top-app/cpu.uclamp.max max.effective max
write /dev/cpuctl/audio-app/cpu.uclamp.max.effective max
write /dev/cpuctl/h-background/cpu.uclamp.max.effective max
write /dev/cpuctl/l-background/cpu.uclamp.max.effective max
write /dev/cpuctl/display/cpu.uclamp.max.effective max
write /dev/cpuctl/oiface_fg/cpu.uclamp.max.effective max
write /dev/cpuctl/sf/cpu.uclamp.max.effective max
write /dev/cpuctl/dex2oat/cpu.uclamp.max.effective max
write /dev/cpuctl/foreground_window/cpu.uclamp.max.effective max
write /dev/cpuctl/system/cpu.uclamp.max.effective max

write /dev/cpuctl/background/cpu.uclamp.min max
write /dev/cpuctl/foreground/cpu.uclamp.min max
write /dev/cpuctl/camera-daemon/cpu.uclamp.min max
write /dev/cpuctl/system-background/cpu.uclamp.min max
write /dev/cpuctl/nnapi-hal/cpu.uclamp.min max
write /dev/cpuctl/rt/cpu.uclamp.min max
write /dev/cpuctl/application/cpu.uclamp.min max
write /dev/cpuctl/kernel/cpu.uclamp.min max
write /dev/cpuctl/restricted/cpu.uclamp.min max
write /dev/cpuctl/top-app/cpu.uclamp.min max
write /dev/cpuctl/audio-app/cpu.uclamp.min max
write /dev/cpuctl/h-background/cpu.uclamp.min max
write /dev/cpuctl/l-background/cpu.uclamp.min max
write /dev/cpuctl/display/cpu.uclamp.min max
write /dev/cpuctl/oiface_fg/cpu.uclamp.min max
write /dev/cpuctl/sf/cpu.uclamp.min max
write /dev/cpuctl/dex2oat/cpu.uclamp.min max
write /dev/cpuctl/foreground_window/cpu.uclamp.min max
write /dev/cpuctl/system/cpu.uclamp.min max

write /dev/cpuctl/background/cpu.uclamp.min.effective max
write /dev/cpuctl/foreground/cpu.uclamp.min.effective max
write /dev/cpuctl/camera-daemon/cpu.uclamp.min.effective max
write /dev/cpuctl/system-background/cpu.uclamp.min.effective max
write /dev/cpuctl/nnapi-hal/cpu.uclamp.min.effective max
write /dev/cpuctl/rt/cpu.uclamp.min.effective max
write /dev/cpuctl/application/cpu.uclamp.min.effective max
write /dev/cpuctl/kernel/cpu.uclamp.min.effective max
write /dev/cpuctl/restricted/cpu.uclamp.min.effective max
write /dev/cpuctl/top-app/cpu.uclamp.min.effective max
write /dev/cpuctl/audio-app/cpu.uclamp.min.effective max
write /dev/cpuctl/h-background/cpu.uclamp.min.effective max
write /dev/cpuctl/l-background/cpu.uclamp.min.effective max
write /dev/cpuctl/display/cpu.uclamp.min.effective max
write /dev/cpuctl/oiface_fg/cpu.uclamp.min.effective max
write /dev/cpuctl/sf/cpu.uclamp.min.effective max
write /dev/cpuctl/dex2oat/cpu.uclamp.min.effective max
write /dev/cpuctl/foreground_window/cpu.uclamp.min.effective max
write /dev/cpuctl/system/cpu.uclamp.min.effective max

write /proc/sys/kernel/sched_util_clamp_min 1024
write /proc/sys/kernel/sched_util_clamp_max 1024
write /proc/sys/kernel/sched_util_clamp_min_rt_default 1024

write /dev/cpuset/cpus 0-1
write /dev/cpuset/cpus 0-2
write /dev/cpuset/cpus 0-3
write /dev/cpuset/cpus 0-4
write /dev/cpuset/cpus 0-5
write /dev/cpuset/cpus 0-6
write /dev/cpuset/cpus 0-7
write /dev/cpuset/cpus 0-8
write /dev/cpuset/cpus 0-9
write /dev/cpuset/cpus 0-10
write /dev/cpuset/cpus 0-11

write /dev/cpuset/background/cpus 0-1
write /dev/cpuset/background/cpus 0-2
write /dev/cpuset/background/cpus 0-3
write /dev/cpuset/background/cpus 0-4
write /dev/cpuset/background/cpus 0-5
write /dev/cpuset/background/cpus 0-6
write /dev/cpuset/background/cpus 0-7
write /dev/cpuset/background/cpus 0-8
write /dev/cpuset/background/cpus 0-9
write /dev/cpuset/background/cpus 0-10
write /dev/cpuset/background/cpus 0-11

write /dev/cpuset/foreground/cpus 0-1
write /dev/cpuset/foreground/cpus 0-2
write /dev/cpuset/foreground/cpus 0-3
write /dev/cpuset/foreground/cpus 0-4
write /dev/cpuset/foreground/cpus 0-5
write /dev/cpuset/foreground/cpus 0-6
write /dev/cpuset/foreground/cpus 0-7
write /dev/cpuset/foreground/cpus 0-8
write /dev/cpuset/foreground/cpus 0-9
write /dev/cpuset/foreground/cpus 0-10
write /dev/cpuset/foreground/cpus 0-11

write /dev/cpuset/rt/cpus 0-1
write /dev/cpuset/rt/cpus 0-2
write /dev/cpuset/rt/cpus 0-3
write /dev/cpuset/rt/cpus 0-4
write /dev/cpuset/rt/cpus 0-5
write /dev/cpuset/rt/cpus 0-6
write /dev/cpuset/rt/cpus 0-7
write /dev/cpuset/rt/cpus 0-8
write /dev/cpuset/rt/cpus 0-9
write /dev/cpuset/rt/cpus 0-10
write /dev/cpuset/rt/cpus 0-11

write /dev/cpuset/top-app/cpus 0-1
write /dev/cpuset/top-app/cpus 0-2
write /dev/cpuset/top-app/cpus 0-3
write /dev/cpuset/top-app/cpus 0-4
write /dev/cpuset/top-app/cpus 0-5
write /dev/cpuset/top-app/cpus 0-6
write /dev/cpuset/top-app/cpus 0-7
write /dev/cpuset/top-app/cpus 0-8
write /dev/cpuset/top-app/cpus 0-9
write /dev/cpuset/top-app/cpus 0-10
write /dev/cpuset/top-app/cpus 0-11

write /dev/cpuset/nnapi-hal 0-1
write /dev/cpuset/nnapi-hal 0-2
write /dev/cpuset/nnapi-hal 0-3
write /dev/cpuset/nnapi-hal 0-4
write /dev/cpuset/nnapi-hal 0-5
write /dev/cpuset/nnapi-hal 0-6
write /dev/cpuset/nnapi-hal 0-7
write /dev/cpuset/nnapi-hal 0-8
write /dev/cpuset/nnapi-hal 0-9
write /dev/cpuset/nnapi-hal 0-10
write /dev/cpuset/nnapi-hal 0-11

write /dev/cpuset/application/cpus 0-1
write /dev/cpuset/application/cpus 0-2
write /dev/cpuset/application/cpus 0-3
write /dev/cpuset/application/cpus 0-4
write /dev/cpuset/application/cpus 0-5
write /dev/cpuset/application/cpus 0-6
write /dev/cpuset/application/cpus 0-7
write /dev/cpuset/application/cpus 0-8
write /dev/cpuset/application/cpus 0-9
write /dev/cpuset/application/cpus 0-10
write /dev/cpuset/application/cpus 0-11

write /dev/cpuset/system/cpus 0-1
write /dev/cpuset/system/cpus 0-2
write /dev/cpuset/system/cpus 0-3
write /dev/cpuset/system/cpus 0-4
write /dev/cpuset/system/cpus 0-5
write /dev/cpuset/system/cpus 0-6
write /dev/cpuset/system/cpus 0-7
write /dev/cpuset/system/cpus 0-8
write /dev/cpuset/system/cpus 0-9
write /dev/cpuset/system/cpus 0-10
write /dev/cpuset/system/cpus 0-11

write /dev/cpuset/system-background/cpus 0-1
write /dev/cpuset/system-background/cpus 0-2
write /dev/cpuset/system-background/cpus 0-3
write /dev/cpuset/system-background/cpus 0-4
write /dev/cpuset/system-background/cpus 0-5
write /dev/cpuset/system-background/cpus 0-6
write /dev/cpuset/system-background/cpus 0-7
write /dev/cpuset/system-background/cpus 0-8
write /dev/cpuset/system-background/cpus 0-9
write /dev/cpuset/system-background/cpus 0-10
write /dev/cpuset/system-background/cpus 0-11

write /dev/cpuset/kernel/cpus 0-1
write /dev/cpuset/kernel/cpus 0-2
write /dev/cpuset/kernel/cpus 0-3
write /dev/cpuset/kernel/cpus 0-4
write /dev/cpuset/kernel/cpus 0-5
write /dev/cpuset/kernel/cpus 0-6
write /dev/cpuset/kernel/cpus 0-7
write /dev/cpuset/kernel/cpus 0-8
write /dev/cpuset/kernel/cpus 0-9
write /dev/cpuset/kernel/cpus 0-10
write /dev/cpuset/kernel/cpus 0-11

write /dev/cpuset/camera-daemon/cpus 0-1
write /dev/cpuset/camera-daemon/cpus 0-2
write /dev/cpuset/camera-daemon/cpus 0-3
write /dev/cpuset/camera-daemon/cpus 0-4
write /dev/cpuset/camera-daemon/cpus 0-5
write /dev/cpuset/camera-daemon/cpus 0-6
write /dev/cpuset/camera-daemon/cpus 0-7
write /dev/cpuset/camera-daemon/cpus 0-8
write /dev/cpuset/camera-daemon/cpus 0-9
write /dev/cpuset/camera-daemon/cpus 0-10
write /dev/cpuset/camera-daemon/cpus 0-11

write /dev/cpuset/restricted/cpus 0-1
write /dev/cpuset/restricted/cpus 0-2
write /dev/cpuset/restricted/cpus 0-3
write /dev/cpuset/restricted/cpus 0-4
write /dev/cpuset/restricted/cpus 0-5
write /dev/cpuset/restricted/cpus 0-6
write /dev/cpuset/restricted/cpus 0-7
write /dev/cpuset/restricted/cpus 0-8
write /dev/cpuset/restricted/cpus 0-9
write /dev/cpuset/restricted/cpus 0-10
write /dev/cpuset/restricted/cpus 0-11

write /dev/cpuset/sf/cpus 0-1
write /dev/cpuset/sf/cpus 0-2
write /dev/cpuset/sf/cpus 0-3
write /dev/cpuset/sf/cpus 0-4
write /dev/cpuset/sf/cpus 0-5
write /dev/cpuset/sf/cpus 0-6
write /dev/cpuset/sf/cpus 0-7
write /dev/cpuset/sf/cpus 0-8
write /dev/cpuset/sf/cpus 0-9
write /dev/cpuset/sf/cpus 0-10
write /dev/cpuset/sf/cpus 0-11

write /dev/cpuset/oiface_fg/cpus 0-1
write /dev/cpuset/oiface_fg/cpus 0-2
write /dev/cpuset/oiface_fg/cpus 0-3
write /dev/cpuset/oiface_fg/cpus 0-4
write /dev/cpuset/oiface_fg/cpus 0-5
write /dev/cpuset/oiface_fg/cpus 0-6
write /dev/cpuset/oiface_fg/cpus 0-7
write /dev/cpuset/oiface_fg/cpus 0-8
write /dev/cpuset/oiface_fg/cpus 0-9
write /dev/cpuset/oiface_fg/cpus 0-10
write /dev/cpuset/oiface_fg/cpus 0-11

write /dev/cpuset/display/cpus 0-1
write /dev/cpuset/display/cpus 0-2
write /dev/cpuset/display/cpus 0-3
write /dev/cpuset/display/cpus 0-4
write /dev/cpuset/display/cpus 0-5
write /dev/cpuset/display/cpus 0-6
write /dev/cpuset/display/cpus 0-7
write /dev/cpuset/display/cpus 0-8
write /dev/cpuset/display/cpus 0-9
write /dev/cpuset/display/cpus 0-10
write /dev/cpuset/display/cpus 0-11

write /dev/cpuset/l-background/cpus 0-1
write /dev/cpuset/l-background/cpus 0-2
write /dev/cpuset/l-background/cpus 0-3
write /dev/cpuset/l-background/cpus 0-4
write /dev/cpuset/l-background/cpus 0-5
write /dev/cpuset/l-background/cpus 0-6
write /dev/cpuset/l-background/cpus 0-7
write /dev/cpuset/l-background/cpus 0-8
write /dev/cpuset/l-background/cpus 0-9
write /dev/cpuset/l-background/cpus 0-10
write /dev/cpuset/l-background/cpus 0-11

write /dev/cpuset/h-background/cpus 0-1
write /dev/cpuset/h-background/cpus 0-2
write /dev/cpuset/h-background/cpus 0-3
write /dev/cpuset/h-background/cpus 0-4
write /dev/cpuset/h-background/cpus 0-5
write /dev/cpuset/h-background/cpus 0-6
write /dev/cpuset/h-background/cpus 0-7
write /dev/cpuset/h-background/cpus 0-8
write /dev/cpuset/h-background/cpus 0-9
write /dev/cpuset/h-background/cpus 0-10
write /dev/cpuset/h-background/cpus 0-11

write /dev/cpuset/audio-app/cpus 0-1
write /dev/cpuset/audio-app/cpus 0-2
write /dev/cpuset/audio-app/cpus 0-3
write /dev/cpuset/audio-app/cpus 0-4
write /dev/cpuset/audio-app/cpus 0-5
write /dev/cpuset/audio-app/cpus 0-6
write /dev/cpuset/audio-app/cpus 0-7
write /dev/cpuset/audio-app/cpus 0-8
write /dev/cpuset/audio-app/cpus 0-9
write /dev/cpuset/audio-app/cpus 0-10
write /dev/cpuset/audio-app/cpus 0-11

write /dev/cpuset/dex2oat/cpus 0-1
write /dev/cpuset/dex2oat/cpus 0-2
write /dev/cpuset/dex2oat/cpus 0-3
write /dev/cpuset/dex2oat/cpus 0-4
write /dev/cpuset/dex2oat/cpus 0-5
write /dev/cpuset/dex2oat/cpus 0-6
write /dev/cpuset/dex2oat/cpus 0-7
write /dev/cpuset/dex2oat/cpus 0-8
write /dev/cpuset/dex2oat/cpus 0-9
write /dev/cpuset/dex2oat/cpus 0-10
write /dev/cpuset/dex2oat/cpus 0-11

write /dev/cpuset/foreground_window/cpus 0-1
write /dev/cpuset/foreground_window/cpus 0-2
write /dev/cpuset/foreground_window/cpus 0-3
write /dev/cpuset/foreground_window/cpus 0-4
write /dev/cpuset/foreground_window/cpus 0-5
write /dev/cpuset/foreground_window/cpus 0-6
write /dev/cpuset/foreground_window/cpus 0-7
write /dev/cpuset/foreground_window/cpus 0-8
write /dev/cpuset/foreground_window/cpus 0-9
write /dev/cpuset/foreground_window/cpus 0-10
write /dev/cpuset/foreground_window/cpus 0-11

# Memory
write /sys/block/zram0/initstate 1
write /proc/sys/vm/stat_interval 1
write /proc/sys/vm/dirty_ratio 10
write /proc/sys/vm/dirty_background_ratio 10
write /proc/sys/vm/vfs_cache_pressure 100
write /proc/sys/vm/swappiness 100
write /proc/sys/vm/watermark_scale_factor 100
write /proc/sys/vm/min_free_kbytes 1000
write /proc/sys/vm/extra_free_kbytes 1000
write /proc/sys/vm/user_reserve_kbytes 1000
write /proc/sys/vm/admin_reserve_kbytes 1000
write /proc/sys/vm/overcommit_free_kbytes 1000
write /proc/sys/vm/dirty_expire_centisecs 10000
write /proc/sys/vm/dirty_writeback_centisecs 10000
write /sys/module/lowmemorykiller/parameters/minfree 0,0,0,0,0,0
write /proc/sys/vm/drop_caches 0
write /proc/sys/vm/laptop_mode 0
write /proc/sys/vm/page-cluster 0
write /proc/sys/vm/overcommit_ratio 0
write /proc/sys/vm/overcommit_memory 0
write /proc/sys/vm/watermark_boost_factor 0
write /proc/sys/vm/oom_kill_allocating_task 0
write /sys/module/lowmemorykiller/parameters/oom_reaper 0
write /sys/module/lowmemorykiller/parameters/lmk_fast_run 0
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/process_reclaim/parameters/enable_process_reclaim 0

# Others parameters
write /sys/kernel/rcu_normal 1
write /sys/fs/selinux/enforce 1
write /sys/kernel/rcu_expedited 1
write /proc/sys/fs/leases-enable 1
write /sys/kernel/fp_boost/enabled 1
write /sys/kernel/mi_reclaim/enable 1
write /proc/sys/fs/dir-notify-enable 1
write /proc/sys/dev/tty/ldisc_autoload 1
write /sys/class/sec/switch/afc_disable 1
write /proc/touchpanel/oplus_tp_direction 1
write /proc/touchpanel/game_switch_enable 1
write /proc/sys/kernel/slide_boost_enabled 1
write /sys/kernel/dyn_fsync/Dyn_fsync_active 1
write /proc/sys/kernel/launcher_boost_enabled 1
write /sys/devices/system/cpu/sched/hint_enable 1
write /sys/module/fast_charge/force_fast_charge 1
write /sys/kernel/fast_charge/force_fast_charge 1
write /sys/module/sync/parameters/fsync_enabled 1
write /sys/class/mmc_host/mmc0/clk_scaling/enable 1
write /sys/class/mmc_host/mmc1/clk_scaling/enable 1
write /sys/module/lpm_levels/parameters/bias_hyst 1
write /sys/kernel/tracing/events/sched/sched_boost_cpu 1
write /sys/class/power_supply/battery/charging_enabled 1
write /proc/sys/fs/lease-break-time 10
write /proc/sys/kernel/random/read_wakeup_threshold 128
write /proc/sys/kernel/random/write_wakeup_threshold 128
write /sys/kernel/oppo_display/LCM_CABC 0
write /proc/touchpanel/oplus_tp_limit_enable 0
write /proc/touchpanel/oplus_tp_limit_enable 0
write /sys/kernel/debug/msm_vidc/fw_low_power_mode 0
write /sys/module/mmc_core/parameters/use_spi_crc 0
write /sys/module/system/cpu/sched_mc_power_savings 0
write /sys/devices/platform/soc/1d84000.ufshc/clkscale_enable 0
write /sys/devices/platform/soc/1d84000.ufshc/hibern8_on_idle_enable 0
write /sys/devices/platform/soc/1d84000.ufshc/clkgate_enable 0
write /sys/module/pm2/parameters/idle_sleep_mode N
write /sys/module/lpm_levels/parameters/lpm_prediction N
write /sys/module/lpm_levels/parameters/lpm_ipi_prediction N
write /sys/module/lpm_levels/parameters/sleep_disabled N
write /sys/module/battery_saver/parameters/enabled N
write /sys/module/workqueue/parameters/power_efficient N
write /sys/module/mmc_core/parameters/removable N
write /sys/module/mmc_core/parameters/use_spi_crc N
write /sys/module/mmc_core/parameters/crc N
write /sys/module/exynos_acme/parameters/enable_suspend_freqs N
write /proc/sys/kernel/printk_devkmsg off

write /sys/kernel/gbe/gbe_enable1 1
write /sys/kernel/gbe/gbe_enable2 1
write /sys/kernel/ged/hal/dcs_mode 1
write /sys/module/ged/parameters/gx_game_mode 1
write /sys/module/ged/parameters/boost_amp 1
write /sys/module/ged/parameters/boost_extra 1
write /sys/module/ged/parameters/boost_gpu_enable 1
write /sys/module/ged/parameters/enable_cpu_boost 1
write /sys/module/ged/parameters/enable_gpu_boost 1
write /sys/module/ged/parameters/gx_frc_mode 1
write /sys/module/ged/parameters/gx_boost_on 1
write /sys/module/ged/parameters/gx_force_cpu_boost 1
write /sys/module/ged/parameters/is_GED_KPI_enabled 1
write /sys/module/ged/parameters/boost_amp 1
write /sys/module/ged/parameters/enable_game_self_frc_detect 1
write /sys/module/ged/parameters/ged_boost_enable 1
write /sys/kernel/gbe/gbe2_max_boost_cnt 1
write /sys/module/ged/parameters/cpu_boost_policy 100
write /sys/module/ged/parameters/ged_smart_boost 100
write /sys/module/ged/parameters/gpu_debug_enable 0
write /sys/module/ged/parameters/gpu_dvfs_enable 0
write /sys/module/ged/parameters/ged_force_mdp_enable 0
write /sys/module/ged/parameters/ged_log_perf_trace_enable 0
write /sys/module/ged/parameters/ged_log_trace_enable 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_debug 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_disable 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_systrace 0

write /proc/perfmgr/tchbst/user/usrtch enable 1
write /proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_enable 1
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_prefer_idle 1
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_fg_boost 1
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_ta_boost 1
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_bg_boost 1
write /proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_up_loading 10
write /proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_down_loading 10
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_uclamp_min 1024
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_fg_uclamp_min 1024
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_ta_uclamp_min 1024
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_bg_uclamp_min 1024

write /proc/ppm/enabled 0
write /proc/ppm/policy_status 0 0
write /proc/ppm/policy_status 1 0
write /proc/ppm/policy_status 2 0
write /proc/ppm/policy_status 3 0
write /proc/ppm/policy_status 4 0
write /proc/ppm/policy_status 5 0
write /proc/ppm/policy_status 6 0
write /proc/ppm/policy_status 7 0
write /proc/ppm/policy_status 8 0
write /proc/ppm/policy_status 9 0
write /proc/ppm/policy_status 10 0
write /proc/ppm/policy_status 11 0

write /sys/devices/system/cpu/cpu0/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu1/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu2/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu3/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu4/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu5/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu6/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu7/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu8/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu9/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu10/core_ctl/min_cpus 4
write /sys/devices/system/cpu/cpu11/core_ctl/min_cpus 4

write /sys/devices/system/cpu/cpu0/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu1/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu2/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu3/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu4/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu5/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu6/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu7/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu8/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu9/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu10/core_ctl/task_thres 100
write /sys/devices/system/cpu/cpu11/core_ctl/task_thres 100

write /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu1/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu2/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu3/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu5/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu6/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu8/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu9/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu10/core_ctl/offline_delay_ms 0
write /sys/devices/system/cpu/cpu11/core_ctl/offline_delay_ms 0

write /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu1/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu2/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu3/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu5/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu6/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu8/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu9/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu10/core_ctl/busy_down_thres 0
write /sys/devices/system/cpu/cpu11/core_ctl/busy_down_thres 0

write /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu1/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu2/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu3/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu5/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu6/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu8/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu9/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu10/core_ctl/busy_up_thres 0
write /sys/devices/system/cpu/cpu11/core_ctl/busy_up_thres 0

# TCP
write /proc/sys/net/ipv4/tcp_ecn 1
write /proc/sys/net/ipv4/tcp_sack 1
write /proc/sys/net/ipv4/tcp_fack 1
write /proc/sys/net/ipv4/route/flush 1
write /proc/sys/net/ipv4/tcp_rfc1337 1
write /proc/sys/net/ipv4/tcp_tw_reuse 1
write /proc/sys/net/ipv4/ip_no_pmtu_disc 1
write /proc/sys/net/ipv4/tcp_timestamps 1
write /proc/sys/net/ipv4/tcp_mtu_probing 1
write /proc/sys/net/ipv4/tcp_tw_recycle 1
write /proc/sys/net/ipv4/tcp_no_metrics_save 1
write /proc/sys/net/ipv4/tcp_window_scaling 1
write /proc/sys/net/ipv4/tcp_syncookies 1
write /proc/sys/net/ipv4/tcp_fastopen 3
write /proc/sys/net/ipv4/tcp_keepalive_probes 10
write /proc/sys/net/ipv4/tcp_keepalive_intvl 10
write /proc/sys/net/ipv4/tcp_fin_timeout 10
write /proc/sys/net/core/netdev_max_backlog 10000
write /proc/sys/net/core/optmem_max 30000
write /proc/sys/net/core/rmem_default 500000
write /proc/sys/net/core/wmem_default 500000
write /proc/sys/net/core/rmem_max 1000000
write /proc/sys/net/core/wmem_max 1000000
write "${tcp_v4}tcp_mem" "100000 300000 500000"
write "${tcp_v4}udp_mem" "100000 300000 500000"
write "${tcp_v4}tcp_rmem" "50000 700000 1000000"
write "${tcp_v4}tcp_wmem" "50000 700000 1000000"
write /proc/sys/net/ipv4/tcp_slow_start_after_idle 0

# CPU/GPU/IO
for governor in /sys/*/system/cpu/*/cpufreq/*
do
	write "$governor/boost" 1
	write "$governor/pl" 1
	write "$governor/fastlane" 1
	write "$governor/fast_ramp_down" 1
	write "$governor/boostpulse" 1
	write "$governor/use_sched_load" 1
	write "$governor/use_migration_notif" 1
	write "$governor/enable_prediction" 1
	write "$governor/sampling_early_factor" 1
	write "$governor/sampling_down_factor" 1
	write "$governor/sampling_interim_factor" 1
	write "$governor/powersave_bias" 1
	write "$governor/ignore_hispeed_on_notif" 1
	write "$governor/param_index" 1
	write "$governor/sampling_down_factor" 1
	write "$governor/enforced_mode" 1
	write "$governor/io_is_busy" 1
	write "$governor/align_windows" 1
	write "$governor/ignore_nice_load" 1
	write "$governor/input_boost" 1
	write "$governor/iowait_boost_enable" 1
	write "$governor/down_differential" 5
	write "$governor/down_differential_multi_core" 5
	write "$governor/target_load_shift" 5
	write "$governor/freq_step" 5
	write "$governor/sched_upmigrate_min_nice" 50
	write "$governor/hispeed_load" 50
	write "$governor/go_hispeed_load" 50
	write "$governor/up_threshold" 50
	write "$governor/target_loads" 50
	write "$governor/single_enter_load" 50
	write "$governor/single_exit_load" 50
	write "$governor/up_threshold_multi_core" 50
	write "$governor/up_threshold_any_cpu_load" 50
	write "$governor/multi_enter_load" 100
	write "$governor/multi_exit_load" 100
	write "$governor/boost_ms" 100
	write "$governor/input_boost_ms" 100
	write "$governor/target_load_thresh" 1000
	write "$governor/timer_rate" 10000
	write "$governor/up_rate_limit_us" 10000
	write "$governor/down_rate_limit_us" 10000
	write "$governor/single_enter_time" 10000
	write "$governor/single_exit_time" 10000
	write "$governor/multi_enter_time" 10000
	write "$governor/multi_exit_time" 10000
	write "$governor/boostpulse_duration" 10000
	write "$governor/min_sample_time" 10000
	write "$governor/timer_slack" 10000
	write "$governor/sampling_rate" 10000
	write "$governor/sampling_rate_min" 10000
	write "$governor/above_hispeed_delay" 10000
	write "$governor/sched_freq_inc_notify" 10000
	write "$governor/sched_freq_dec_notify" 10000
	write "$governor/up_throttle_nsec" 1000000
	write "$governor/down_throttle_nsec" 1000000
	write "$governor/hispeed_freq" 0
	write "$governor/optimal_freq" 0
	write "$governor/sync_freq" 0
	write "$governor/rtg_boost_freq" 0
	write "$governor/adaptive_high_freq" 0
	write "$governor/adaptive_low_freq" 0
	write "$governor/max_freq_hysteresis" 0
	write "$governor/step_up_early_hispeed" 0
	write "$governor/step_up_interim_hispeed" 0
	write "$governor/up_threshold_any_cpu_freq" 0
done

for governor in /sys/*/system/cpu/cpufreq/*
do
	write "$governor/boost" 1
	write "$governor/pl" 1
	write "$governor/fastlane" 1
	write "$governor/fast_ramp_down" 1
	write "$governor/boostpulse" 1
	write "$governor/use_sched_load" 1
	write "$governor/use_migration_notif" 1
	write "$governor/enable_prediction" 1
	write "$governor/sampling_early_factor" 1
	write "$governor/sampling_down_factor" 1
	write "$governor/sampling_interim_factor" 1
	write "$governor/powersave_bias" 1
	write "$governor/ignore_hispeed_on_notif" 1
	write "$governor/param_index" 1
	write "$governor/sampling_down_factor" 1
	write "$governor/enforced_mode" 1
	write "$governor/io_is_busy" 1
	write "$governor/align_windows" 1
	write "$governor/ignore_nice_load" 1
	write "$governor/input_boost" 1
	write "$governor/iowait_boost_enable" 1
	write "$governor/down_differential" 5
	write "$governor/down_differential_multi_core" 5
	write "$governor/target_load_shift" 5
	write "$governor/freq_step" 5
	write "$governor/sched_upmigrate_min_nice" 50
	write "$governor/hispeed_load" 50
	write "$governor/go_hispeed_load" 50
	write "$governor/up_threshold" 50
	write "$governor/target_loads" 50
	write "$governor/single_enter_load" 50
	write "$governor/single_exit_load" 50
	write "$governor/up_threshold_multi_core" 50
	write "$governor/up_threshold_any_cpu_load" 50
	write "$governor/multi_enter_load" 100
	write "$governor/multi_exit_load" 100
	write "$governor/boost_ms" 100
	write "$governor/input_boost_ms" 100
	write "$governor/target_load_thresh" 1000
	write "$governor/timer_rate" 10000
	write "$governor/up_rate_limit_us" 10000
	write "$governor/down_rate_limit_us" 10000
	write "$governor/single_enter_time" 10000
	write "$governor/single_exit_time" 10000
	write "$governor/multi_enter_time" 10000
	write "$governor/multi_exit_time" 10000
	write "$governor/boostpulse_duration" 10000
	write "$governor/min_sample_time" 10000
	write "$governor/timer_slack" 10000
	write "$governor/sampling_rate" 10000
	write "$governor/sampling_rate_min" 10000
	write "$governor/above_hispeed_delay" 10000
	write "$governor/sched_freq_inc_notify" 10000
	write "$governor/sched_freq_dec_notify" 10000
	write "$governor/up_throttle_nsec" 1000000
	write "$governor/down_throttle_nsec" 1000000
	write "$governor/hispeed_freq" 0
	write "$governor/optimal_freq" 0
	write "$governor/sync_freq" 0
	write "$governor/rtg_boost_freq" 0
	write "$governor/adaptive_high_freq" 0
	write "$governor/adaptive_low_freq" 0
	write "$governor/max_freq_hysteresis" 0
	write "$governor/step_up_early_hispeed" 0
	write "$governor/step_up_interim_hispeed" 0
	write "$governor/up_threshold_any_cpu_freq" 0
done

write /sys/kernel/gpu/boost 1
write /proc/mali/always_on 1
write /proc/mali/dvfs_enable 1
write /sys/class/kgsl/kgsl-3d0/tmu 1
write /sys/class/kgsl/kgsl-3d0/popp 1
write /sys/class/kgsl/kgsl-3d0/pwrnap 1
write /sys/class/kgsl/kgsl-3d0/force_bus_on 1
write /sys/class/kgsl/kgsl-3d0/force_clk_on 1
write /sys/class/kgsl/kgsl-3d0/force_rail_on 1
write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 1
write /sys/kernel/debug/sde_rotator0/clk_always_on 1
write /sys/module/mali/parameters/mali_touch_boost_level 1
write /sys/class/simple_gpu_algorithm/parameters/simple_gpu_active 1
write /sys/class/simple_gpu_algorithm/parameters/simple_laziness 1
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/vsync 1
write /sys/module/adreno_idler/parameters/adreno_idler_idlewait 10
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/vsync_downdifferential 10
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/no_vsync_upthreshold 10
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/vsync_upthreshold 10
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/no_vsync_downdifferential 10
write /sys/module/adreno_idler/parameters/adreno_idler_downdifferential 30
write /sys/module/adreno_idler/parameters/adreno_idler_idleworkload 10000
write /sys/class/simple_gpu_algorithm/parameters/simple_ramp_threshold 10000
write /sys/class/kgsl/kgsl-3d0/bus_split 0
write /sys/class/kgsl/kgsl-3d0/throttling 0
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 0
write /sys/class/kgsl/kgsl-3d0/max_pwrlevel 0
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 0
write /sys/class/kgsl/kgsl-3d0/thermal_pwrlevel 0
write /sys/module/adreno_idler/parameters/adreno_idler_active N
write /sys/devices/platform/13040000.mali/power_policy always_on
write /sys/class/kgsl/kgsl-3d0/power_policy always_on

write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 1
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 2
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 3
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 4
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 5
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 6
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 7
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 8
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 9
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 10
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 11
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 12
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 13
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 14
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 15
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 16
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 17
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 18
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 19
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 20
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 21
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 22
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 23
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 24
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 25
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 26
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 27
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 28
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 29
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 30

write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 1
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 2
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 3
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 4
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 5
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 6
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 7
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 8
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 9
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 10
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 11
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 12
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 13
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 14
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 15
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 16
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 17
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 18
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 19
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 20
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 21
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 22
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 23
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 24
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 25
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 26
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 27
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 28
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 29
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 30

for queue in /sys/*/*/queue
do
	write "$queue/iostats" 1
	write "$queue/read_ahead_kb" 4
	write "$queue/read_ahead_kb" 6
	write "$queue/read_ahead_kb" 8
	write "$queue/read_ahead_kb" 16
	write "$queue/read_ahead_kb" 32
	write "$queue/read_ahead_kb" 64
	write "$queue/read_ahead_kb" 128
	write "$queue/read_ahead_kb" 256
	write "$queue/read_ahead_kb" 512
	write "$queue/read_ahead_kb" 1024
	write "$queue/read_ahead_kb" 2048
	write "$queue/read_ahead_kb" 4096
	write "$queue/nr_requests" 4
	write "$queue/nr_requests" 8
	write "$queue/nr_requests" 16
	write "$queue/nr_requests" 32
	write "$queue/nr_requests" 64
	write "$queue/nr_requests" 128
	write "$queue/nr_requests" 256
	write "$queue/nr_requests" 512
	write "$queue/nr_requests" 1024
	write "$queue/nr_requests" 2048
	write "$queue/nr_requests" 4096
done

for queue in /sys/*/*/queue
do
	write "$queue/iosched/front_merges" 100
	write "$queue/iosched/back_seek_penalty" 100
	write "$queue/iosched/slice_async_rq" 100
	write "$queue/iosched/writes_starved" 100
	write "$queue/iosched/async_depth" 100
	write "$queue/iosched/io_threshold" 1000
	write "$queue/iosched/quantum" 1000
	write "$queue/iosched/fifo_batch" 1000
	write "$queue/iosched/slice_async" 1000
	write "$queue/iosched/slice_sync" 1000
	write "$queue/iosched/timeout_sync" 1000
	write "$queue/iosched/back_timeout" 1000
	write "$queue/iosched/fifo_expire_async" 1000
	write "$queue/iosched/fifo_expire_sync" 1000
	write "$queue/iosched/target_latency" 1000
	write "$queue/iosched/read_expire" 10000
	write "$queue/iosched/write_expire" 10000
	write "$queue/iosched/fore_timeout" 10000
	write "$queue/iosched/prio_aging_expire" 10000
	write "$queue/iosched/back_seek_max" 100000
	write "$queue/iosched/aging_expire" 100000
	write "$queue/iosched/slice_sync_us" 100000
	write "$queue/iosched/slice_async_us" 100000
	write "$queue/iosched/target_latency_us" 1000000
	write "$queue/iosched/max_budget" 1000000
	write "$queue/iosched/read_lat_nsec" 1000000000
	write "$queue/iosched/write_lat_nsec" 1000000000
	write "$queue/iosched/strict_guarantees" 0
	write "$queue/iosched/cpq_log" 0
	write "$queue/iosched/slice_idle" 0
	write "$queue/iosched/group_idle" 0
	write "$queue/iosched/low_latency" 0
	write "$queue/iosched/slice_idle_us" 0
	write "$queue/iosched/group_idle_us" 0
done

# CPU Cores
write /sys/devices/system/cpu/cpu0/online 1
write /sys/devices/system/cpu/cpu1/online 1
write /sys/devices/system/cpu/cpu2/online 1
write /sys/devices/system/cpu/cpu3/online 1
write /sys/devices/system/cpu/cpu4/online 1
write /sys/devices/system/cpu/cpu5/online 1
write /sys/devices/system/cpu/cpu6/online 1
write /sys/devices/system/cpu/cpu7/online 1
write /sys/devices/system/cpu/cpu8/online 1
write /sys/devices/system/cpu/cpu9/online 1
write /sys/devices/system/cpu/cpu10/online 1
write /sys/devices/system/cpu/cpu11/online 1

# CPU Clocks/Frequencies
# This is Optional.
# If you want to change it you will have to do it by yourself.
# Since mobile hardware CPU and GPU clocks and frequencies are vary different.
# Most APUs and CPUs clocks and frequencies clusters are divided into 2, 3 or more depend on hardware configurations from OEMs/Manufactuers.
# Available Clocks/Frequencies can be located in this paths - /sys/devices/system/cpu/cpu*/cpufreq/ or /sys/devices/system/cpu/cpufreq/policy*.
write /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq 
write /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq 
write /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq 

write /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq 
write /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq 
write /sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq 

# GPU Clocks/Frequencies
# This is Optional.
# Available Clocks/Frequencies can be located in this paths - /sys/class/kgsl/kgsl-3d0/devfreq/.
# GPU Clocks/Frequencies modification may not work and/or supported due to hardware sources codes limitations from OEMs/Manufactuers.
write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 

# Device Charging Power
# This is Optional.
# On newer Android Device, this method may no longer work or available to use.
# Be sure to set the value correctly - For example: 1500000 = 1500 mAh = Around 5 and 6 Watt.
# Get correct information about the device's max charging current value (Wattage or mAh).
# Otherwise just don't touch this parameters if you don't know about this and let it be.
chmod 666 /sys/class/power_supply/battery/constant_charge_current_max
write /sys/class/power_supply/battery/constant_charge_current_max 
chmod 444 /sys/class/power_supply/battery/constant_charge_current_max 

# Return to completed regardless of any writes that either failed or succeed
exit 0