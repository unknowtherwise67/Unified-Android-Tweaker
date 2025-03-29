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

# Fix Mobile Network
settings put global airplane_mode_on 1
am broadcast -a android.intent.action.AIRPLANE_MODE
settings put global airplane_mode_on 0
am broadcast -a android.intent.action.AIRPLANE_MODE

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
write /proc/sys/kernel/sched_r r_timeslice_us 1000000
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
write /proc/sys/kernel/sched_coloc_busy_hyst_max_ms 1000
write /proc/sys/kernel/sched_freq_aggregate_threshold 1000
write /proc/sys/kernel/sched_many_wakeup_threshold 1000
write /proc/sys/kernel/sched_util_clamp_max 1024
write /proc/sys/kernel/sched_util_clamp_min 1024
write /proc/sys/kernel/sched_util_clamp_min_rt_default 1024
write /proc/sys/kernel/sched_lib_mask_force 100
write /proc/sys/kernel/sched_group_upmigrate 100
write /proc/sys/kernel/sched_group_downmigrate 100
write /proc/sys/kernel/sched_coloc_busy_hysteresis_enable_cpus 100
write /proc/sys/kernel/sched_upmigrate 100
write /proc/sys/kernel/sched_downmigrate 100
write /proc/sys/kernel/sched_asym_cap_sibling_freq_match_pct 100
write /proc/sys/kernel/sched_init_task_load 100
write /proc/sys/kernel/sched_spill_load 100
write /proc/sys/kernel/sched_min_task_util_for_colocation 100
write /proc/sys/kernel/sched_min_task_util_for_boost 100
write /proc/sys/kernel/sched_big_waker_task_load 100
write /proc/sys/kernel/sched_small_wakee_task_load 100
write /proc/sys/kernel/sched_walt_init_task_load_pct 100
write /proc/sys/kernel/sched_cfs_boost 10
write /proc/sys/kernel/perf_cpu_time_max_percent 1
write /proc/sys/kernel/sched_tunable_scaling 1
write /proc/sys/kernel/sched_child_runs_first 1
write /proc/sys/kernel/sched_autogroup_enabled 1
write /proc/sys/kernel/sched_schedstats 1
write /proc/sys/kernel/sched_energy_aware 1
write /proc/sys/kernel/sched_pelt_multiplier 1
write /proc/sys/kernel/sched_ravg_hist_size 1
write /proc/sys/kernel/sched_ravg_window_nr_ticks 1
write /proc/sys/kernel/sched_window_stats_policy 1
write /proc/sys/kernel/sched_force_lb_enable 1
write /proc/sys/kernel/sched_prefer_spread 1
write /proc/sys/kernel/sched_dynamic_ravg_window_enable 1
write /proc/sys/kernel/sched_conservative_pl 1
write /proc/sys/kernel/sched_walt_rotate_big_tasks 1
write /proc/sys/kernel/sched_user_hint 1
write /proc/sys/kernel/sched_sync_hint_enable 1
write /proc/sys/kernel/sched_prefer_sync_wakee_to_waker 1
write /proc/sys/kernel/sched_min_task_util_for_colocation 1
write /proc/sys/kernel/sched_freq_aggregate 1
write /proc/sys/kernel/sched_cstate_aware 1
write /proc/sys/kernel/sched_initial_task_util 1
write /proc/sys/kernel/sched_is_big_little 1
write /proc/sys/kernel/sched_use_walt_cpu_util 1
write /proc/sys/kernel/sched_use_walt_task_util 1
write /proc/sys/kernel/sched_sync_hint_enable 1
write /proc/sys/kernel/sched_wake_to_idle 1
write /proc/sys/kernel/sched_enable_thread_grouping 1
write /proc/sys/kernel/sched_restrict_cluster_spill 1
write /proc/sys/kernel/sched_assist_enabled 1
write /proc/sys/kernel/sched_assist_scenes 1
write /proc/sys/kernel/sched_assist_ux_uclamp_max_enable 1
write /proc/sys/kernel/sched_spill_nr_run 1
write /proc/sys/kernel/sched_little_cluster_coloc_fmin_khz 1
write /proc/sys/kernel/sched_min_task_util_for_boost_colocation 1

write /sys/kernel/debug/sched_features GENTLE_FAIR_SLEEPERS
write /sys/kernel/debug/sched_features HRTICK
write /sys/kernel/debug/sched_features DOUBLE_TICK
write /sys/kernel/debug/sched_features RT_RUNTIME_SHARE
write /sys/kernel/debug/sched_features NEXT_BUDDY
write /sys/kernel/debug/sched_features LAST_BUDDY
write /sys/kernel/debug/sched_features TTWU_QUEUE
write /sys/kernel/debug/sched_features UTIL_EST
write /sys/kernel/debug/sched_features ARCH_CAPACITY
write /sys/kernel/debug/sched_features ARCH_POWER
write /sys/kernel/debug/sched_features START_DEBIT
write /sys/kernel/debug/sched_features CACHE_HOT_BUDDY
write /sys/kernel/debug/sched_features WAKEUP_PREEMPTION
write /sys/kernel/debug/sched_features LB_BIAS
write /sys/kernel/debug/sched_features NONTASK_CAPACITY
write /sys/kernel/debug/sched_features RT_PUSH_IPI
write /sys/kernel/debug/sched_features FORCE_SD_OVERLAP
write /sys/kernel/debug/sched_features LB_MIN
write /sys/kernel/debug/sched_features ATTACH_AGE_LOAD
write /sys/kernel/debug/sched_features SIS_AVG_CPU
write /sys/kernel/debug/sched_features MIN_CAPACITY_CAPPING
write /sys/kernel/debug/sched_features FBT_STRICT_ORDER
write /sys/kernel/debug/sched_features EAS_USE_NEED_IDLE

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

write /dev/stune/schedtune.prefer_idle 0
write /dev/stune/background/schedtune.prefer_idle 0
write /dev/stune/foreground/schedtune.prefer_idle 0
write /dev/stune/rt/schedtune.prefer_idle 0
write /dev/stune/application/schedtune.prefer_idle 0
write /dev/stune/kernel/schedtune.prefer_idle 0
write /dev/stune/restricted/schedtune.prefer_idle 0
write /dev/stune/camera-daemon/schedtune.prefer_idle 0
write /dev/stune/nnapi-hal/schedtune.prefer_idle 0
write /dev/stune/system-background/schedtune.prefer_idle 0
write /dev/stune/top-app/schedtune.prefer_idle 0
write /dev/stune/audio/schedtune.prefer_idle 0
write /dev/stune/h-background/schedtune.prefer_idle 0
write /dev/stune/l-background/schedtune.prefer_idle 0
write /dev/stune/display/schedtune.prefer_idle 0
write /dev/stune/oiface_fg/schedtune.prefer_idle 0
write /dev/stune/sf/schedtune.prefer_idle 0

write /dev/stune/cpu.uclamp.latency_sensitive 0
write /dev/stune/background/cpu.uclamp.latency_sensitive 0
write /dev/stune/foreground/cpu.uclamp.latency_sensitive 0
write /dev/stune/rt/cpu.uclamp.latency_sensitive 0
write /dev/stune/application/cpu.uclamp.latency_sensitive 0
write /dev/stune/kernel/cpu.uclamp.latency_sensitive 0
write /dev/stune/restricted/cpu.uclamp.latency_sensitive 0
write /dev/stune/camera-daemon/cpu.uclamp.latency_sensitive 0
write /dev/stune/nnapi-hal/cpu.uclamp.latency_sensitive 0
write /dev/stune/system-background/cpu.uclamp.latency_sensitive 0
write /dev/stune/top-app/cpu.uclamp.latency_sensitive 0
write /dev/stune/audio/cpu.uclamp.latency_sensitive 0
write /dev/stune/h-background/cpu.uclamp.latency_sensitive 0
write /dev/stune/l-background/cpu.uclamp.latency_sensitive 0
write /dev/stune/display/cpu.uclamp.latency_sensitive 0
write /dev/stune/oiface_fg/cpu.uclamp.latency_sensitive 0
write /dev/stune/sf/cpu.uclamp.latency_sensitive 0

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

write /dev/stune/background/schedtune.uclamp.max.effective 1024
write /dev/stune/foreground/schedtune.uclamp.max.effective 1024
write /dev/stune/camera-daemon/schedtune.uclamp.max.effective 1024
write /dev/stune/system-background/schedtune.uclamp.max.effective 1024
write /dev/stune/nnapi-hal/schedtune.uclamp.max.effective 1024
write /dev/stune/rt/schedtune.uclamp.max.effective 1024
write /dev/stune/application/schedtune.uclamp.max.effective 1024
write /dev/stune/kernel/schedtune.uclamp.max.effective 1024
write /dev/stune/restricted/schedtune.uclamp.max.effective 1024
write /dev/stune/top-app/schedtune.uclamp.max max.effective 1024
write /dev/stune/audio-app/schedtune.uclamp.max.effective 1024
write /dev/stune/h-background/schedtune.uclamp.max.effective 1024
write /dev/stune/l-background/schedtune.uclamp.max.effective 1024
write /dev/stune/display/schedtune.uclamp.max.effective 1024
write /dev/stune/oiface_fg/schedtune.uclamp.max.effective 1024
write /dev/stune/sf/schedtune.uclamp.max.effective 1024

write /dev/stune/background/schedtune.uclamp.min 1024
write /dev/stune/foreground/schedtune.uclamp.min 1024
write /dev/stune/camera-daemon/schedtune.uclamp.min 1024
write /dev/stune/system-background/schedtune.uclamp.min 1024
write /dev/stune/nnapi-hal/schedtune.uclamp.min 1024
write /dev/stune/rt/schedtune.uclamp.min 1024
write /dev/stune/application/schedtune.uclamp.min 1024
write /dev/stune/kernel/schedtune.uclamp.min 1024
write /dev/stune/restricted/schedtune.uclamp.min 1024
write /dev/stune/top-app/schedtune.uclamp.min 1024
write /dev/stune/audio-app/schedtune.uclamp.min 1024
write /dev/stune/h-background/schedtune.uclamp.min 1024
write /dev/stune/l-background/schedtune.uclamp.min 1024
write /dev/stune/display/schedtune.uclamp.min 1024
write /dev/stune/oiface_fg/schedtune.uclamp.min 1024
write /dev/stune/sf/schedtune.uclamp.min 1024

write /dev/stune/background/schedtune.uclamp.min.effective 1024
write /dev/stune/foreground/schedtune.uclamp.min.effective 1024
write /dev/stune/camera-daemon/schedtune.uclamp.min.effective 1024
write /dev/stune/system-background/schedtune.uclamp.min.effective 1024
write /dev/stune/nnapi-hal/schedtune.uclamp.min.effective 1024
write /dev/stune/rt/schedtune.uclamp.min.effective 1024
write /dev/stune/application/schedtune.uclamp.min.effective 1024
write /dev/stune/kernel/schedtune.uclamp.min.effective 1024
write /dev/stune/restricted/schedtune.uclamp.min.effective 1024
write /dev/stune/top-app/schedtune.uclamp.min.effective 1024
write /dev/stune/audio-app/schedtune.uclamp.min.effective 1024
write /dev/stune/h-background/schedtune.uclamp.min.effective 1024
write /dev/stune/l-background/schedtune.uclamp.min.effective 1024
write /dev/stune/display/schedtune.uclamp.min.effective 1024
write /dev/stune/oiface_fg/schedtune.uclamp.min.effective 1024
write /dev/stune/sf/schedtune.uclamp.min.effective 1024

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
write /proc/sys/vm/stat_interval 1
write /proc/sys/vm/page-cluster 3
write /proc/sys/vm/dirty_background_ratio 5
write /proc/sys/vm/dirty_ratio 10
write /proc/sys/vm/swappiness 100
write /proc/sys/vm/overcommit_ratio 100
write /proc/sys/vm/vfs_cache_pressure 100
write /proc/sys/vm/dirty_expire_centisecs 1000
write /proc/sys/vm/dirty_writeback_centisecs 1000
write /proc/sys/vm/min_free_kbytes 1000
write /proc/sys/vm/admin_reserve_kbytes 1000
write /proc/sys/vm/extra_free_kbytes 1000
write /proc/sys/vm/user_reserve_kbytes 10000
write /sys/module/lowmemorykiller/parameters/minfree 0,0,0,0,0,0
write /proc/sys/vm/laptop_mode 0
write /proc/sys/vm/drop_caches 0
write /proc/sys/vm/overcommit_free_kbytes 0
write /proc/sys/vm/oom_kill_allocating_task 0
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
write /sys/module/pm2/parameters/idle_sleep_mode Y
write /sys/module/lpm_levels/parameters/lpm_prediction Y
write /sys/module/lpm_levels/parameters/lpm_ipi_prediction Y
write /sys/module/lpm_levels/parameters/sleep_disabled Y
write /sys/module/battery_saver/parameters/enabled N
write /sys/module/workqueue/parameters/power_efficient N
write /sys/module/mmc_core/parameters/removable N
write /sys/module/mmc_core/parameters/use_spi_crc N
write /sys/module/mmc_core/parameters/crc N
write /sys/module/exynos_acme/parameters/enable_suspend_freqs N
write /proc/sys/kernel/printk_devkmsg off
Modify CPUStune

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
write /sys/module/ged/parameters/gpu_dvfs_enable 1
write /sys/kernel/gbe/gbe2_max_boost_cnt 1
write /sys/kernel/gbe/gbe2_loading_th 10
write /sys/module/ged/parameters/gpu_idle 10
write /sys/kernel/ged/hal/timer_base_dvfs_margin 15
write /sys/kernel/ged/hal/dvfs_margin_value 15
write /sys/module/ged/parameters/cpu_boost_policy 100
write /sys/module/ged/parameters/ged_smart_boost 100
write /sys/module/ged/parameters/gpu_debug_enable 0
write /sys/module/ged/parameters/ged_force_mdp_enable 0
write /sys/module/ged/parameters/ged_log_perf_trace_enable 0
write /sys/module/ged/parameters/ged_log_trace_enable 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_debug 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_disable 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_systrace 0

write /proc/ppm/enabled 1
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
write /proc/sys/net/ipv4/tcp_syncookies 0

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
	write "$governor/down_differential" 1
	write "$governor/down_differential_multi_core" 1
	write "$governor/target_load_shift" 1
	write "$governor/freq_step" 1
	write "$governor/sched_upmigrate_min_nice" 1
	write "$governor/hispeed_load" 10
	write "$governor/up_threshold" 10
	write "$governor/target_loads" 10
	write "$governor/go_hispeed_load" 10
	write "$governor/up_threshold_multi_core" 10
	write "$governor/up_threshold_any_cpu_load" 10
	write "$governor/single_enter_load" 10
	write "$governor/single_exit_load" 10
	write "$governor/multi_enter_load" 50
	write "$governor/multi_exit_load" 50
	write "$governor/boost_ms" 100
	write "$governor/input_boost_ms" 100
	write "$governor/timer_rate" 100
	write "$governor/up_rate_limit_us" 100
	write "$governor/down_rate_limit_us" 100
	write "$governor/single_enter_time" 100
	write "$governor/single_exit_time" 100
	write "$governor/multi_enter_time" 100
	write "$governor/multi_exit_time" 100
	write "$governor/boostpulse_duration" 100
	write "$governor/min_sample_time" 100
	write "$governor/timer_slack" 100
	write "$governor/sampling_rate" 100
	write "$governor/sampling_rate_min" 100
	write "$governor/target_load_thresh" 128
	write "$governor/above_hispeed_delay" 1000
	write "$governor/sched_freq_inc_notify" 1000
	write "$governor/sched_freq_dec_notify" 1000
	write "$governor/up_throttle_nsec" 10000
	write "$governor/down_throttle_nsec" 10000
	write "$governor/sync_freq" 100000
	write "$governor/hispeed_freq" 100000
	write "$governor/optimal_freq" 100000
	write "$governor/rtg_boost_freq" 100000
	write "$governor/adaptive_high_freq" 100000
	write "$governor/adaptive_low_freq" 100000
	write "$governor/max_freq_hysteresis" 100000
	write "$governor/step_up_early_hispeed" 100000
	write "$governor/step_up_interim_hispeed" 100000
	write "$governor/up_threshold_any_cpu_freq" 100000
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
	write "$governor/down_differential" 1
	write "$governor/down_differential_multi_core" 1
	write "$governor/target_load_shift" 1
	write "$governor/freq_step" 1
	write "$governor/sched_upmigrate_min_nice" 1
	write "$governor/hispeed_load" 10
	write "$governor/up_threshold" 10
	write "$governor/target_loads" 10
	write "$governor/go_hispeed_load" 10
	write "$governor/up_threshold_multi_core" 10
	write "$governor/up_threshold_any_cpu_load" 10
	write "$governor/single_enter_load" 10
	write "$governor/single_exit_load" 10
	write "$governor/multi_enter_load" 50
	write "$governor/multi_exit_load" 50
	write "$governor/boost_ms" 100
	write "$governor/input_boost_ms" 100
	write "$governor/timer_rate" 100
	write "$governor/up_rate_limit_us" 100
	write "$governor/down_rate_limit_us" 100
	write "$governor/single_enter_time" 100
	write "$governor/single_exit_time" 100
	write "$governor/multi_enter_time" 100
	write "$governor/multi_exit_time" 100
	write "$governor/boostpulse_duration" 100
	write "$governor/min_sample_time" 100
	write "$governor/timer_slack" 100
	write "$governor/sampling_rate" 100
	write "$governor/sampling_rate_min" 100
	write "$governor/target_load_thresh" 128
	write "$governor/above_hispeed_delay" 1000
	write "$governor/sched_freq_inc_notify" 1000
	write "$governor/sched_freq_dec_notify" 1000
	write "$governor/up_throttle_nsec" 10000
	write "$governor/down_throttle_nsec" 10000
	write "$governor/sync_freq" 100000
	write "$governor/hispeed_freq" 100000
	write "$governor/optimal_freq" 100000
	write "$governor/rtg_boost_freq" 100000
	write "$governor/adaptive_high_freq" 100000
	write "$governor/adaptive_low_freq" 100000
	write "$governor/max_freq_hysteresis" 100000
	write "$governor/step_up_early_hispeed" 100000
	write "$governor/step_up_interim_hispeed" 100000
	write "$governor/up_threshold_any_cpu_freq" 100000
done

write /sys/module/cpu_boost/parameters/input_boost_ms 1
write /sys/module/cpu_boost/parameters/input_boost_enabled 1
write /sys/module/cpu_boost/parameters/sched_boost_on_input 1
write /sys/module/cpu_boost/parameters/dynamic_stune_boost_ms 1
write /sys/module/cpu_boost/parameters/powerkey_input_boost_ms 1
write /sys/module/cpu_input_boost/parameters/input_boost_duration 1
write /sys/module/cpu_boost/parameters/sched_boost_on_powerkey_input 1
write /sys/module/cpu_boost/parameters/dynamic_stune_boost 10

write /proc/cpufreq/cpufreq_power_mode 1
write /proc/cpufreq/cpufreq_stress_test 1
write /proc/cpufreq/cpufreq_sched_disable 1
write /proc/cpufreq/cpufreq_cci_mode 1
write /sys/devices/system/cpu/perf/enable 1
write /sys/devices/system/cpu/cpuidle/use_deepest_state 1

write /sys/kernel/hmp/boost 1
write /sys/kernel/hmp/down_compensation_enabled 1
write /sys/kernel/hmp/family_boost 1
write /sys/kernel/hmp/semiboost 1
write /sys/kernel/hmp/up_threshold 100
write /sys/kernel/hmp/down_threshold 100

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
write /sys/class/kgsl/kgsl-3d0/max_pwrlevel 0
write /sys/class/kgsl/kgsl-3d0/thermal_pwrlevel 0
write /sys/module/adreno_idler/parameters/adreno_idler_active Y
write /sys/devices/platform/13040000.mali/power_policy always_on
write /sys/class/kgsl/kgsl-3d0/power_policy always_on

write /sys/module/cpu_boost/parameters/input_boost_freq 0:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 1:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 2:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 3:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 4:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 5:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 6:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 7:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 8:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 9:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 10:1000000
write /sys/module/cpu_boost/parameters/input_boost_freq 11:1000000

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
	write "$queue/iosched/slice_async_rq" 1
	write "$queue/iosched/writes_starved" 1
	write "$queue/iosched/async_depth" 1
	write "$queue/iosched/back_seek_penalty" 1
	write "$queue/iosched/quantum" 1
	write "$queue/iosched/io_threshold" 1
	write "$queue/iosched/slice_async" 1
	write "$queue/iosched/fifo_batch" 1
	write "$queue/iosched/slice_sync" 10
	write "$queue/iosched/timeout_sync" 10
	write "$queue/iosched/back_timeout" 10
	write "$queue/iosched/fifo_expire_async" 10
	write "$queue/iosched/fifo_expire_sync" 10
	write "$queue/iosched/read_expire" 50
	write "$queue/iosched/write_expire" 50
	write "$queue/iosched/fore_timeout" 50
	write "$queue/iosched/target_latency" 50
	write "$queue/iosched/aging_expire" 100
	write "$queue/iosched/back_seek_max" 100
	write "$queue/iosched/slice_sync_us" 100
	write "$queue/iosched/slice_async_us" 100
	write "$queue/iosched/target_latency_us" 1000
	write "$queue/iosched/prio_aging_expire" 1000
	write "$queue/iosched/read_lat_nsec" 10000
	write "$queue/iosched/write_lat_nsec" 10000
	write "$queue/iosched/cpq_log" 0
	write "$queue/iosched/slice_idle" 0
	write "$queue/iosched/group_idle" 0
	write "$queue/iosched/max_budget" 0
	write "$queue/iosched/low_latency" 0
	write "$queue/iosched/front_merges" 0
	write "$queue/iosched/slice_idle_us" 0
	write "$queue/iosched/group_idle_us" 0
	write "$queue/iosched/strict_guarantees" 0
done

# Return to completed regardless of any writes that failed or succeed
exit 0