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

# Sync Data
sync

# Device Settings
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
settings put global adaptive_battery_management_enabled 0
settings put global tether_offload_disabled 0
settings put global wifi_power_save 0
settings put global ble_scan_always_enabled 0
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

# Schedulers
write /proc/sys/kernel/sched_schedstats 1
write /proc/sys/kernel/sched_latency_ns 1000000000
write /proc/sys/kernel/sched_migration_cost_ns 1000000000
write /proc/sys/kernel/sched_min_granularity_ns 1000000000
write /proc/sys/kernel/sched_wakeup_granularity_ns 1000000000
write /proc/sys/kernel/sched_nr_migrate 1000000000
write /proc/sys/kernel/sched_rr_timeslice_us 1000000000
write /proc/sys/kernel/sched_deadline_period_max_us 1000000000
write /proc/sys/kernel/sched_deadline_period_min_us 1000000000
write /proc/sys/kernel/sched_walt_cpu_high_irqload 1000000000
write /proc/sys/kernel/sched_shares_window 1000000000
write /proc/sys/kernel/sched_shares_window_ns 1000000000
write /proc/sys/kernel/sched_freq_aggregate_threshold 1000000000
write /proc/sys/kernel/sched_freq_dec_notify 1000000000
write /proc/sys/kernel/sched_freq_inc_notify 1000000000
write /proc/sys/kernel/sched_pred_alert_freq 1000000000
write /proc/sys/kernel/sched_short_burst_ns 1000000000
write /proc/sys/kernel/sched_short_sleep_ns 1000000000
write /proc/sys/kernel/sched_rr_timeslice_ms 1000000000
write /proc/sys/kernel/sched_time_avg_ms 1000000000
write /proc/sys/kernel/sched_select_prev_cpu_us 1000000000
write /proc/sys/kernel/sched_time_avg 1000000000
write /proc/sys/kernel/sched_coloc_busy_hyst_ns 1000000000
write /proc/sys/kernel/sched_task_unfilter_period 100000000
write /proc/sys/kernel/sched_rt_period_us 1000000
write /proc/sys/kernel/sched_rt_runtime_us 1000000
write /proc/sys/kernel/sched_coloc_busy_hyst_max_ms 10000
write /proc/sys/kernel/sched_freq_aggregate_threshold 1000
write /proc/sys/kernel/sched_many_wakeup_threshold 1000
write /proc/sys/kernel/sched_util_clamp_max 1024
write /proc/sys/kernel/sched_util_clamp_min 1024
write /proc/sys/kernel/sched_lib_mask_force 250
write /proc/sys/kernel/sched_group_upmigrate 150
write /proc/sys/kernel/sched_group_downmigrate 150
write /proc/sys/kernel/sched_coloc_busy_hysteresis_enable_cpus 150
write /proc/sys/kernel/sched_upmigrate 100
write /proc/sys/kernel/sched_downmigrate 100
write /proc/sys/kernel/sched_asym_cap_sibling_freq_match_pct 100
write /proc/sys/kernel/sched_init_task_load 50
write /proc/sys/kernel/sched_spill_load 50
write /proc/sys/kernel/sched_min_task_util_for_colocation 50
write /proc/sys/kernel/sched_min_task_util_for_boost 50
write /proc/sys/kernel/sched_big_waker_task_load 50
write /proc/sys/kernel/sched_small_wakee_task_load 50
write /proc/sys/kernel/sched_walt_init_task_load_pct 50
write /proc/sys/kernel/sched_cfs_boost 10
write /proc/sys/kernel/sched_ravg_hist_size 5
write /proc/sys/kernel/sched_ravg_window_nr_ticks 3
write /proc/sys/kernel/sched_window_stats_policy 3
write /proc/sys/kernel/perf_cpu_time_max_percent 0
write /proc/sys/kernel/sched_force_lb_enable 0
write /proc/sys/kernel/sched_prefer_spread 0
write /proc/sys/kernel/sched_dynamic_ravg_window_enable 0
write /proc/sys/kernel/sched_conservative_pl 0
write /proc/sys/kernel/sched_walt_rotate_big_tasks 0
write /proc/sys/kernel/sched_user_hint 0
write /proc/sys/kernel/sched_sync_hint_enable 0
write /proc/sys/kernel/sched_autogroup_enabled 0
write /proc/sys/kernel/sched_child_runs_first 0
write /proc/sys/kernel/sched_tunable_scaling 0
write /proc/sys/kernel/sched_prefer_sync_wakee_to_waker 0
write /proc/sys/kernel/sched_min_task_util_for_colocation 0
write /proc/sys/kernel/sched_util_clamp_min_rt_default 0
write /proc/sys/kernel/sched_freq_aggregate 0
write /proc/sys/kernel/sched_energy_aware 0
write /proc/sys/kernel/sched_pelt_multiplier 0
write /proc/sys/kernel/sched_cstate_aware 0
write /proc/sys/kernel/sched_initial_task_util 0
write /proc/sys/kernel/sched_is_big_little 0
write /proc/sys/kernel/sched_use_walt_cpu_util 0
write /proc/sys/kernel/sched_use_walt_task_util 0
write /proc/sys/kernel/sched_sync_hint_enable 0
write /proc/sys/kernel/sched_wake_to_idle 0
write /proc/sys/kernel/sched_enable_thread_grouping 0
write /proc/sys/kernel/sched_restrict_cluster_spill 0
write /proc/sys/kernel/sched_assist_enabled 0
write /proc/sys/kernel/sched_assist_scenes 0
write /proc/sys/kernel/sched_assist_ux_uclamp_max_enable 0
write /proc/sys/kernel/sched_spill_nr_run 0

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

# Schedtune Idles/Boosts/CPUs-Set
write /dev/stune/schedtune.boost 10
write /dev/stune/background/schedtune.boost 10
write /dev/stune/foreground/schedtune.boost 10
write /dev/stune/camera-daemon/schedtune.boost 10
write /dev/stune/system-background/schedtune.boost 10
write /dev/stune/nnapi-hal/schedtune.boost 10
write /dev/stune/rt/schedtune.boost 10
write /dev/stune/application/schedtune.boost 10
write /dev/stune/kernel/schedtune.boost 10
write /dev/stune/restricted/schedtune.boost 10
write /dev/stune/top-app/schedtune.boost 10
write /dev/stune/audio-app/schedtune.boost 10
write /dev/stune/h-background/schedtune.boost 10
write /dev/stune/l-background/schedtune.boost 10
write /dev/stune/display/schedtune.boost 10
write /dev/stune/oiface_fg/schedtune.boost 10
write /dev/stune/sf/schedtune.boost 10

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

write /dev/stune/schedtune.sched_boost_no_override 0
write /dev/stune/background/schedtune.sched_boost_no_override 0
write /dev/stune/foreground/schedtune.sched_boost_no_override 0
write /dev/stune/camera-daemon/schedtune.sched_boost_no_override 0
write /dev/stune/system-background/schedtune.sched_boost_no_override 0
write /dev/stune/nnapi-hal/schedtune.sched_boost_no_override 0
write /dev/stune/application/schedtune.sched_boost_no_override 0
write /dev/stune/kernel/schedtune.sched_boost_no_override 0
write /dev/stune/restricted/schedtune.sched_boost_no_override 0
write /dev/stune/top-app/schedtune.sched_boost_no_override 0
write /dev/stune/audio-app/schedtune.sched_boost_no_override 0
write /dev/stune/h-background/schedtune.sched_boost_no_override 0
write /dev/stune/l-background/schedtune.sched_boost_no_override 0
write /dev/stune/display/schedtune.sched_boost_no_override 0
write /dev/stune/oiface_fg/schedtune.sched_boost_no_override 0
write /dev/stune/sf/schedtune.sched_boost_no_override 0

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
rite /dev/stune/audio/schedtune.prefer_idle 1
rite /dev/stune/h-background/schedtune.prefer_idle 1
rite /dev/stune/l-background/schedtune.prefer_idle 1
rite /dev/stune/display/schedtune.prefer_idle 1
rite /dev/stune/oiface_fg/schedtune.prefer_idle 1
rite /dev/stune/sf/schedtune.prefer_idle 1

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

write /dev/stune/background/schedtune.uclamp.max.effective 4096
write /dev/stune/foreground/schedtune.uclamp.max.effective 4096
write /dev/stune/camera-daemon/schedtune.uclamp.max.effective 4096
write /dev/stune/system-background/schedtune.uclamp.max.effective 4096
write /dev/stune/nnapi-hal/schedtune.uclamp.max.effective 4096
write /dev/stune/rt/schedtune.uclamp.max.effective 4096
write /dev/stune/application/schedtune.uclamp.max.effective 4096
write /dev/stune/kernel/schedtune.uclamp.max.effective 4096
write /dev/stune/restricted/schedtune.uclamp.max.effective 4096
write /dev/stune/top-app/schedtune.uclamp.max max.effective 4096
write /dev/stune/audio-app/schedtune.uclamp.max.effective 4096
write /dev/stune/h-background/schedtune.uclamp.max.effective 4096
write /dev/stune/l-background/schedtune.uclamp.max.effective 4096
write /dev/stune/display/schedtune.uclamp.max.effective 4096
write /dev/stune/oiface_fg/schedtune.uclamp.max.effective 4096
write /dev/stune/sf/schedtune.uclamp.max.effective 4096

write /dev/stune/background/schedtune.uclamp.min 0.00
write /dev/stune/foreground/schedtune.uclamp.min 0.00
write /dev/stune/camera-daemon/schedtune.uclamp.min 0.00
write /dev/stune/system-background/schedtune.uclamp.min 0.00
write /dev/stune/nnapi-hal/schedtune.uclamp.min 0.00
write /dev/stune/rt/schedtune.uclamp.min 0.00
write /dev/stune/application/schedtune.uclamp.min 0.00
write /dev/stune/kernel/schedtune.uclamp.min 0.00
write /dev/stune/restricted/schedtune.uclamp.min 0.00
write /dev/stune/top-app/schedtune.uclamp.min 0.00
write /dev/stune/audio-app/schedtune.uclamp.min 0.00
write /dev/stune/h-background/schedtune.uclamp.min 0.00
write /dev/stune/l-background/schedtune.uclamp.min 0.00
write /dev/stune/display/schedtune.uclamp.min 0.00
write /dev/stune/oiface_fg/schedtune.uclamp.min 0.00
write /dev/stune/sf/schedtune.uclamp.min 0.00

write /dev/stune/background/schedtune.uclamp.min.effective 0
write /dev/stune/foreground/schedtune.uclamp.min.effective 0
write /dev/stune/camera-daemon/schedtune.uclamp.min.effective 0
write /dev/stune/system-background/schedtune.uclamp.min.effective 0
write /dev/stune/nnapi-hal/schedtune.uclamp.min.effective 0
write /dev/stune/rt/schedtune.uclamp.min.effective 0
write /dev/stune/application/schedtune.uclamp.min.effective 0
write /dev/stune/kernel/schedtune.uclamp.min.effective 0
write /dev/stune/restricted/schedtune.uclamp.min.effective 0
write /dev/stune/top-app/schedtune.uclamp.min.effective 0
write /dev/stune/audio-app/schedtune.uclamp.min.effective 0
write /dev/stune/h-background/schedtune.uclamp.min.effective 0
write /dev/stune/l-background/schedtune.uclamp.min.effective 0
write /dev/stune/display/schedtune.uclamp.min.effective 0
write /dev/stune/oiface_fg/schedtune.uclamp.min.effective 0
write /dev/stune/sf/schedtune.uclamp.min.effective 0

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

# Memory
write /proc/sys/vm/page-cluster 3
write /proc/sys/vm/drop_caches 3
write /proc/sys/vm/dirty_background_ratio 100
write /proc/sys/vm/dirty_ratio 100
write /proc/sys/vm/swappiness 100
write /proc/sys/vm/overcommit_ratio 100
write /proc/sys/vm/vfs_cache_pressure 100
write /proc/sys/vm/dirty_expire_centisecs 10000
write /proc/sys/vm/dirty_writeback_centisecs 10000
write /sys/module/lowmemorykiller/parameters/minfree 0,0,0,0,0,0
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/lowmemorykiller/parameters/lmk_fast_run 0
write /sys/module/process_reclaim/parameters/enable_process_reclaim 0

# Others parameters
write /sys/fs/selinux/enforce 1
write /sys/class/power_supply/battery/charging_enabled 1
write /sys/module/fast_charge/force_fast_charge 1
write /sys/kernel/fast_charge/force_fast_charge 1
write /sys/module/sync/parameters/fsync_enabled 1
write /sys/module/workqueue/parameters/power_efficient N
write /sys/module/mmc_core/parameters/use_spi_crc 0
write /sys/module/system/cpu/sched_mc_power_savings 0
write /proc/sys/kernel/random/read_wakeup_threshold 128
write /proc/sys/kernel/random/write_wakeup_threshold 128
write /proc/touchpanel/game_switch_enable 1
write /proc/touchpanel/oplus_tp_direction 1
write /proc/touchpanel/oplus_tp_limit_enable 0
write /sys/kernel/oppo_display/LCM_CABC 0
write /proc/sys/kernel/printk_devkmsg off
Modify CPUStune

write /sys/module/ged/parameters/ged_force_mdp_enable 0
write /sys/module/ged/parameters/gx_game_mode 1
write /sys/module/ged/parameters/boost_amp 1
write /sys/module/ged/parameters/boost_extra 1
write /sys/module/ged/parameters/boost_gpu_enable 1
write /sys/module/ged/parameters/enable_cpu_boost 1
write /sys/module/ged/parameters/enable_gpu_boost 1
write /sys/module/ged/parameters/gx_frc_mode 1
write /sys/module/ged/parameters/gx_boost_on 1
write /sys/module/ged/parameters/gx_force_cpu_boost 1
write /sys/module/ged/parameters/enable_game_self_frc_detect 1
write /sys/module/ged/parameters/ged_boost_enable 1
write /sys/module/ged/parameters/gpu_idle 10
write /sys/module/ged/parameters/cpu_boost_policy 100
write /sys/module/ged/parameters/ged_smart_boost 100

settings put global settings_enable_monitor_phantom_procs false
setprop persist.sys.fflag.override.settings_enable_monitor_phantom_procs false
dumpsys deviceidle disable

# Thermal/Processor Controls
stop thermal
setprop ctl.stop mpdecision;stop mpdecision
write /sys/module/msm_thermal/core_control/enabled 0
write /sys/module/msm_thermal/vdd_restriction/enabled 0

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

# TCP
write /proc/sys/net/ipv4/tcp_ecn 1
write /proc/sys/net/ipv4/tcp_fastopen 3
write /proc/sys/net/ipv4/tcp_syncookies 0

# CPU/GPU/IO
write /proc/cpufreq/cpufreq_power_mode 3
write /proc/cpufreq/cpufreq_cci_mode 1
write /sys/devices/system/cpu/perf/enable 1

write /sys/class/kgsl/kgsl-3d0/throttling 0
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 6
write /sys/class/simple_gpu_algorithm/parameters/simple_gpu_active 1
write /sys/class/simple_gpu_algorithm/parameters/simple_ramp_threshold 10000
write /sys/class/simple_gpu_algorithm/parameters/simple_laziness 0
write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 3
write /sys/class/kgsl/kgsl-3d0/force_bus_on 1
write /sys/class/kgsl/kgsl-3d0/force_clk_on 1
write /sys/class/kgsl/kgsl-3d0/force_rail_on 1
write /proc/mali/always_on 1
write /sys/devices/platform/13040000.mali/power_policy always_on

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



for queue in /sys/*/*/queue
do
	avail_scheds="$(cat "$queue/scheduler")"
	for sched in mq-deadline deadline kyber fiops bfq cfq noop
	do
		if [[ "$avail_scheds" == *"$sched"* ]]
		then
			write "$queue/scheduler" "$sched"
			break
		fi
	done

	write "$queue/iostats" 1
	write "$queue/rq_affinity" 2
	write "$queue/read_ahead_kb" 2048
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

# Return to completed regardless of any writes that failed or succeed
exit 0