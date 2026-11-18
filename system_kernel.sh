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

# CPU/GPU/IO
for governor in /sys/*/system/cpu/*/cpufreq/* /sys/*/system/cpu/cpufreq/*
do
	write "$governor/boost" 1
    write "$governor/pl" 1
    write "$governor/io_is_busy" 1
    write "$governor/timer_slack" -1
    write "$governor/freq_step" 5
    write "$governor/iowait_boost_enable" 1
	write "$governor/boost" 1
    write "$governor/fastlane" 1
    write "$governor/fast_ramp_down" 1
    write "$governor/boostpulse" 1
    write "$governor/use_sched_load" 1
    write "$governor/use_migration_notif" 1
    write "$governor/enable_prediction" 1
    write "$governor/io_is_busy" 1
    write "$governor/align_windows" 1
    write "$governor/ignore_nice_load" 1
    write "$governor/input_boost" 1
    write "$governor/iowait_boost_enable" 1
    write "$governor/target_load_shift" 5
    write "$governor/enforced_mode" 1
    write "$governor/target_load_shift" 5
    write "$governor/sched_upmigrate_min_nice" -5
    write "$governor/down_differential" 35
    write "$governor/up_threshold" 60
    write "$governor/go_hispeed_load" 65
    write "$governor/hispeed_load" 65
    write "$governor/target_loads" "65 1400000:75 1800000:85"
    write "$governor/single_enter_load" 60
    write "$governor/single_exit_load" 90
    write "$governor/up_threshold_any_cpu_load" 65
    write "$governor/target_load_thresh" 65
    write "$governor/multi_enter_load" 85
    write "$governor/multi_exit_load" 95
    write "$governor/input_boost_ms" 100
    write "$governor/boost_ms" 200
    write "$governor/single_enter_time" 2000
    write "$governor/timer_rate" 5000
    write "$governor/sampling_rate" 5000
    write "$governor/up_rate_limit_us" 2000
    write "$governor/down_rate_limit_us" 20000
    write "$governor/single_exit_time" 50000
    write "$governor/multi_enter_time" 5000
    write "$governor/sampling_rate_min" 5000
    write "$governor/above_hispeed_delay" "10000 1200000:20000"
    write "$governor/sched_freq_inc_notify" 25000
    write "$governor/multi_exit_time" 50000
    write "$governor/min_sample_time" 40000
    write "$governor/boostpulse_duration" 200000
    write "$governor/sched_freq_dec_notify" 250000
    write "$governor/up_throttle_nsec" 5000000
    write "$governor/down_throttle_nsec" 5000000
done

write /sys/kernel/gpu/boost 1
write /proc/mali/always_on 1
write /proc/mali/dvfs_enable 1
write /sys/module/ged/parameters/gpu_dvfs_enable 1
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

for dev_dir in /sys/block/*; do
    dev=$(basename "$dev_dir")
    case "$dev" in
        loop*|dm-*|zram*|ram*|sr*|md*) continue ;;
    esac
    queue="$dev_dir/queue"
    [ -d "$queue" ] || continue
    if [ -f "$queue/rotational" ]; then
        is_rotational=$(cat "$queue/rotational")
    else
        is_rotational=0
    fi
    write "$queue/add_random" 0
    write "$queue/iostats" 1
    write "$queue/rq_affinity" 2
    if [ "$is_rotational" -eq 1 ]; then
        write "$queue/rotational" 1
        write "$queue/read_ahead_kb" 2048
        write "$queue/nomerges" 0
        write "$queue/nr_requests" 256
    else
        write "$queue/rotational" 0
        write "$queue/read_ahead_kb" 128
        write "$queue/nomerges" 2
        write "$queue/nr_requests" 128
    fi
    iosched="$queue/iosched"
    [ -d "$iosched" ] || continue
    [ -f "$iosched/front_merges" ] && write "$iosched/front_merges" 1
    [ -f "$iosched/back_seek_penalty" ] && write "$iosched/back_seek_penalty" 1
    [ -f "$iosched/back_seek_max" ] && write "$iosched/back_seek_max" 1048576
    [ -f "$iosched/fore_timeout" ] && write "$iosched/fore_timeout" 5
    [ -f "$iosched/back_timeout" ] && write "$iosched/back_timeout" 10
    [ -f "$iosched/timeout_sync" ] && write "$iosched/timeout_sync" 10
    [ -f "$iosched/slice_async_rq" ] && write "$iosched/slice_async_rq" 1
    [ -f "$iosched/writes_starved" ] && write "$iosched/writes_starved" 3
    [ -f "$iosched/async_depth" ] && write "$iosched/async_depth" 8
    [ -f "$iosched/io_threshold" ] && write "$iosched/io_threshold" 16
    [ -f "$iosched/quantum" ] && write "$iosched/quantum" 8
    [ -f "$iosched/fifo_batch" ] && write "$iosched/fifo_batch" 16
    [ -f "$iosched/slice_async" ] && write "$iosched/slice_async" 10
    [ -f "$iosched/slice_sync" ] && write "$iosched/slice_sync" 10
    [ -f "$iosched/max_budget" ] && write "$iosched/max_budget" 16
    [ -f "$iosched/fifo_expire_async" ] && write "$iosched/fifo_expire_async" 30
    [ -f "$iosched/read_expire" ] && write "$iosched/read_expire" 50
    [ -f "$iosched/fifo_expire_sync" ] && write "$iosched/fifo_expire_sync" 50
    [ -f "$iosched/target_latency" ] && write "$iosched/target_latency" 100
    [ -f "$iosched/write_expire" ] && write "$iosched/write_expire" 100
    [ -f "$iosched/aging_expire" ] && write "$iosched/aging_expire" 5000
    [ -f "$iosched/prio_aging_expire" ] && write "$iosched/prio_aging_expire" 10000
    [ -f "$iosched/slice_sync_us" ] && write "$iosched/slice_sync_us" 10000
    [ -f "$iosched/slice_async_us" ] && write "$iosched/slice_async_us" 5000
    [ -f "$iosched/target_latency_us" ] && write "$iosched/target_latency_us" 100000
    [ -f "$iosched/read_lat_nsec" ] && write "$iosched/read_lat_nsec" 1000000
    [ -f "$iosched/write_lat_nsec" ] && write "$iosched/write_lat_nsec" 1000000
    [ -f "$iosched/strict_guarantees" ] && write "$iosched/strict_guarantees" 0
    [ -f "$iosched/cpq_log" ] && write "$iosched/cpq_log" 0
    [ -f "$iosched/slice_idle" ] && write "$iosched/slice_idle" 0
    [ -f "$iosched/group_idle" ] && write "$iosched/group_idle" 0
    [ -f "$iosched/low_latency" ] && write "$iosched/low_latency" 0
    [ -f "$iosched/slice_idle_us" ] && write "$iosched/slice_idle_us" 0
    [ -f "$iosched/group_idle_us" ] && write "$iosched/group_idle_us" 0
done

# Memory
write /sys/block/zram0/initstate 1
write /proc/sys/vm/stat_interval 1
write /proc/sys/vm/overcommit_memory 1
write /proc/sys/vm/page-cluster 0
write /proc/sys/vm/dirty_background_ratio 5
write /proc/sys/vm/dirty_ratio 10
write /proc/sys/vm/watermark_scale_factor 10
write /proc/sys/vm/overcommit_ratio 100
write /proc/sys/vm/vfs_cache_pressure 100
write /proc/sys/vm/swappiness 100
write /proc/sys/vm/min_free_kbytes 1000
write /proc/sys/vm/extra_free_kbytes 1000
write /proc/sys/vm/user_reserve_kbytes 1000
write /proc/sys/vm/admin_reserve_kbytes 1000
write /proc/sys/vm/overcommit_free_kbytes 1000
write /proc/sys/vm/dirty_expire_centisecs 10000
write /proc/sys/vm/dirty_writeback_centisecs 10000
write /proc/sys/vm/laptop_mode 0
write /proc/sys/vm/oom_kill_allocating_task 0
write /sys/module/lowmemorykiller/parameters/oom_reaper 0
write /sys/module/lowmemorykiller/parameters/lmk_fast_run 0
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/process_reclaim/parameters/enable_process_reclaim 0

write /sys/block/zram0/initstate 1
write /proc/sys/vm/stat_interval 10
write /proc/sys/vm/overcommit_memory 1
write /proc/sys/vm/page-cluster 0
write /proc/sys/vm/dirty_background_ratio 5
write /proc/sys/vm/dirty_ratio 10
write /proc/sys/vm/dirty_expire_centisecs 3000
write /proc/sys/vm/dirty_writeback_centisecs 5000
write /proc/sys/vm/min_free_kbytes 16384
write /proc/sys/vm/extra_free_kbytes 12288
write /proc/sys/vm/user_reserve_kbytes 8192
write /proc/sys/vm/admin_reserve_kbytes 4096
write /proc/sys/vm/watermark_scale_factor 10
write /proc/sys/vm/overcommit_ratio 100
write /proc/sys/vm/vfs_cache_pressure 100
write /proc/sys/vm/swappiness 100
write /sys/module/lowmemorykiller/parameters/minfree 0,0,0,0,0,0
write /proc/sys/vm/drop_caches 0
write /proc/sys/vm/laptop_mode 0
write /proc/sys/vm/oom_kill_allocating_task 0
write /sys/module/lowmemorykiller/parameters/oom_reaper 0
write /sys/module/lowmemorykiller/parameters/lmk_fast_run 0
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/process_reclaim/parameters/enable_process_reclaim 0

# Schedulers
for sched in /proc/sys/kernel/ /sys/kernel/debug/
do
	write "$sched/sched_task_unfilter_period" 200000000
	write "$sched/sched_latency_ns" 12000000
	write "$sched/sched_min_granularity_ns" 2000000
	write "$sched/sched_wakeup_granularity_ns" 2000000
	write "$sched/sched_short_burst_ns" 5000000
	write "$sched/sched_short_sleep_ns" 2000000
	write "$sched/sched_migration_cost_ns" 1000000
	write "$sched/sched_select_prev_cpu_us" 1000
	write "$sched/sched_shares_window_ns" 10000000
	write "$sched/sched_shares_window" 10000000
	write "$sched/sched_time_avg" 1000
	write "$sched/sched_time_avg_ms" 100
	write "$sched/sched_ravg_hist_size" 3
	write "$sched/sched_pelt_multiplier" 4
	write "$sched/sched_window_stats_policy" 2
	write "$sched/sched_ravg_window_nr_ticks" 1
	write "$sched/sched_deadline_period_max_us" 4194304
	write "$sched/sched_deadline_period_min_us" 100
	write "$sched/sched_rt_period_us" 1000000
	write "$sched/sched_rt_runtime_us" 1000000
	write "$sched/sched_rr_timeslice_us" 100000
	write "$sched/sched_rr_timeslice_ms" 100
	write "$sched/sched_util_clamp_max" 1024
	write "$sched/sched_util_clamp_min" 1024
	write "$sched/sched_util_clamp_min_rt_default" 1024
	write "$sched/sched_cfs_boost" 10
	write "$sched/schedtune.boost" 10
	write "$sched/sched_stune_task_threshold" 5
	write "$sched/sched_min_task_util_for_boost" 0
	write "$sched/sched_min_task_util_for_boost_colocation" 50
	write "$sched/sched_nr_migrate" 32
	write "$sched/sched_spill_load" 100
	write "$sched/sched_spill_nr_run" 5
	write "$sched/sched_asym_cap_sibling_freq_match_pct" 70
	write "$sched/sched_upmigrate" 50
	write "$sched/sched_downmigrate" 50
	write "$sched/sched_group_upmigrate" 50
	write "$sched/sched_group_downmigrate" 50
	write "$sched/sched_walt_init_task_load_pct" 50
	write "$sched/sched_init_task_load" 50
	write "$sched/sched_initial_task_util" 128
	write "$sched/sched_many_wakeup_threshold" 10
	write "$sched/sched_walt_cpu_high_irqload" 10
	write "$sched/sched_big_waker_task_load" 10
	write "$sched/sched_restrict_cluster_spill" 1
	write "$sched/sched_force_lb_enable" 0
	write "$sched/sched_prefer_spread" 0
	write "$sched/sched_coloc_busy_hyst_ns" 50000000
	write "$sched/sched_coloc_busy_hysteresis_enable_cpus" 255
	write "$sched/sched_coloc_busy_hyst_max_ms" 30
	write "$sched/sched_assist_scenes" 255
	write "$sched/sched_assist_enabled" 1
	write "$sched/sched_assist_ux_uclamp_max_enable" 0
	write "$sched/sched_enable_thread_grouping" 1
	write "$sched/sched_min_task_util_for_colocation" 0
	write "$sched/sched_little_cluster_coloc_fmin_khz" 0
	write "$sched/sched_walt_rotate_big_tasks" 1
	write "$sched/sched_big_task_rotation" 1
	write "$sched/sched_isolation_hint" 1
	write "$sched/sched_user_hint" 1
	write "$sched/sched_sync_hint_enable" 1
	write "$sched/sched_prefer_sync_wakee_to_waker" 1
	write "$sched/sched_freq_aggregate" 1
	write "$sched/sched_freq_aggregate_threshold" 1
	write "$sched/sched_freq_dec_notify" 1
	write "$sched/sched_freq_inc_notify" 1
	write "$sched/sched_pred_alert_freq" 0
	write "$sched/sched_energy_aware" 0
	write "$sched/sched_cstate_aware" 1
	write "$sched/sched_tunable_scaling" 0
	write "$sched/sched_conservative_pl" 0
	write "$sched/perf_cpu_time_max_percent" 1
	write "$sched/sched_schedstats" 1
	write "$sched/sched_autogroup_enabled" 1
	write "$sched/sched_is_big_little" 1
	write "$sched/sched_use_walt_task_util" 2
	write "$sched/sched_use_walt_cpu_util" 1
	write "$sched/sched_wake_to_idle" 1
	write "$sched/sched_small_wakee_task_load" 0
	write "$sched/sched_child_runs_first" 0
	write "$sched/sched_dynamic_ravg_window_enable" 0
done

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

# TCP
write net/ipv4/tcp_ecn 2
write net/ipv4/tcp_sack 1
write net/ipv4/tcp_fack 0
write net/ipv4/tcp_timestamps 1
write net/ipv4/tcp_window_scaling 1
write net/ipv4/tcp_tw_reuse 1
write net/ipv4/tcp_tw_recycle 0
write net/ipv4/tcp_rfc1337 1
write net/ipv4/tcp_fin_timeout 15
write net/ipv4/tcp_keepalive_probes 5
write net/ipv4/tcp_keepalive_intvl 10
write net/ipv4/tcp_fastopen 3
write net/ipv4/tcp_syncookies 1
write net/core/netdev_max_backlog 8192
write net/core/optmem_max 65536
write net/core/rmem_default 524288
write net/core/wmem_default 524288
write net/core/rmem_max 16777216
write net/core/wmem_max 16777216
write net/ipv4/tcp_mtu_probing 1
write net/ipv4/tcp_no_metrics_save 1
write net/ipv4/tcp_slow_start_after_idle 0
write net/ipv4/ip_no_pmtu_disc 0
write net/ipv4/route/flush 1

# Others parameters
write sys/kernel/rcu_normal 1
write sys/kernel/rcu_expedited 1
write proc/sys/fs/leases-enable 1
write sys/kernel/fp_boost/enabled 1
write sys/kernel/mi_reclaim/enable 1
write proc/sys/fs/dir-notify-enable 1
write proc/sys/dev/tty/ldisc_autoload 1
write sys/class/sec/switch/afc_disable 1
write proc/touchpanel/oplus_tp_direction 1
write proc/touchpanel/game_switch_enable 1
write proc/sys/kernel/slide_boost_enabled 1
write sys/kernel/dyn_fsync/Dyn_fsync_active 1
write proc/sys/kernel/launcher_boost_enabled 1
write sys/devices/system/cpu/sched/hint_enable 1
write sys/module/fast_charge/force_fast_charge 1
write sys/kernel/fast_charge/force_fast_charge 1
write sys/module/sync/parameters/fsync_enabled 1
write sys/class/mmc_host/mmc0/clk_scaling/enable 1
write sys/class/mmc_host/mmc1/clk_scaling/enable 1
write sys/module/lpm_levels/parameters/bias_hyst 1
write sys/kernel/tracing/events/sched/sched_boost_cpu 1
write sys/class/power_supply/battery/charging_enabled 1
write proc/cpufreq/cpufreq_power_mode 3
write proc/sys/fs/lease-break-time 5
write proc/sys/kernel/random/read_wakeup_threshold 256
write proc/sys/kernel/random/write_wakeup_threshold 256
write sys/kernel/oppo_display/LCM_CABC 0
write proc/touchpanel/oplus_tp_limit_enable 0
write sys/kernel/debug/msm_vidc/fw_low_power_mode 0
write sys/module/mmc_core/parameters/use_spi_crc 0
write sys/module/system/cpu/sched_mc_power_savings 0
write /sys/devices/platform/soc/1d84000.ufshc/clkscale_enable 0
write /sys/devices/platform/soc/1d84000.ufshc/hibern8_on_idle_enable 0
write /sys/devices/platform/soc/1d84000.ufshc/clkgate_enable 0
write sys/module/pm2/parameters/idle_sleep_mode N
write sys/module/lpm_levels/parameters/lpm_prediction N
write sys/module/lpm_levels/parameters/lpm_ipi_prediction N
write sys/module/lpm_levels/parameters/sleep_disabled N
write sys/module/battery_saver/parameters/enabled N
write sys/module/workqueue/parameters/power_efficient 0
write sys/module/mmc_core/parameters/removable N
write sys/module/mmc_core/parameters/crc 0
write sys/module/exynos_acme/parameters/enable_suspend_freqs N
write proc/sys/kernel/printk_devkmsg off
write sys/kernel/gbe/gbe_enable1 1
write sys/kernel/gbe/gbe_enable2 1
write sys/kernel/ged/hal/dcs_mode 1

write sys/module/ged/parameters/gx_game_mode 1
write sys/module/ged/parameters/boost_amp 1
write sys/module/ged/parameters/boost_extra 1
write sys/module/ged/parameters/boost_gpu_enable 1
write sys/module/ged/parameters/enable_cpu_boost 1
write sys/module/ged/parameters/enable_gpu_boost 1
write sys/module/ged/parameters/gx_frc_mode 1
write sys/module/ged/parameters/gx_boost_on 1
write sys/module/ged/parameters/gx_force_cpu_boost 1
write sys/module/ged/parameters/is_GED_KPI_enabled 1
write sys/module/ged/parameters/enable_game_self_frc_detect 1
write sys/module/ged/parameters/ged_boost_enable 1
write sys/module/ged/parameters/gx_3D_benchmark_on 1
write sys/module/ged/parameters/cpu_boost_policy 100
write sys/module/ged/parameters/ged_smart_boost 100
write sys/module/ged/parameters/gx_fb_dvfs_margin 100
write sys/module/ged/parameters/gx_tb_dvfs_margin 0
write sys/module/ged/parameters/target_t_cpu_remained 0
write sys/module/ged/parameters/gpu_debug_enable 0
write sys/module/ged/parameters/ged_force_mdp_enable 0
write sys/module/ged/parameters/ged_log_perf_trace_enable 0
write sys/module/ged/parameters/ged_log_trace_enable 0
write sys/module/ged/parameters/ged_monitor_3D_fence_debug 0
write sys/module/ged/parameters/ged_monitor_3D_fence_disable 0
write sys/module/ged/parameters/ged_monitor_3D_fence_systrace 0

write proc/perfmgr/tchbst/user/usrtch enable 1
write proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_enable 1
write proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_prefer_idle 1
write proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_fg_boost 1
write proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_ta_boost 1
write proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_bg_boost 1
write proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_up_loading 30
write proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_down_loading 10
write proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_uclamp_min 1024
write proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_fg_uclamp_min 1024
write proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_ta_uclamp_min 1024
write proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_bg_uclamp_min 1024

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

write /sys/module/msm_thermal/core_control/enabled 1
write /sys/module/msm_thermal/vdd_restriction/enabled 1
write /sys/module/msm_thermal/parameters/enabled Y

# Schedtunes/Stunes/Uclamps/Cpuctl/Core_Ctl
for stune in /dev/stune/* /dev/cpuctl/*
do
    write "$stune/schedtune.boost" 10
    write "$stune/sched_cfs_boost" 10
    write "$stune/schedtune.colocate" 1
    write "$stune/schedtune.sched_boost_enabled" 1
    write "$stune/schedtune.prefer_high_cap" 1
    write "$stune/schedtune.prefer_idle" 1
    write "$stune/cpu.uclamp.latency_sensitive" 1
    write "$stune/schedtune.sched_boost_no_override" 1
    write "$stune/cgroup.sane_behavior" 0
    write "$stune/schedtune.capacity_min" 100
    write "$stune/schedtune.cpucapacity_min" 100
    write "$stune/schedtune.uclamp.min.effective" 100
    write "$stune/cpu.cpucapacity_min" 100
    write "$stune/cpu.uclamp.max.effective" 100
done

write /proc/sys/kernel/sched_util_clamp_min 1024
write /proc/sys/kernel/sched_util_clamp_max 1024
write /proc/sys/kernel/sched_util_clamp_min_rt_default 1024

for core_ctl in /sys/*/system/cpu/*/core_ctl/
do
    write "$core_ctl/min_cpus" 4
    write "$core_ctl/task_thres" 100
    write "$core_ctl/offline_delay_ms" 0
    write "$core_ctl/busy_up_thres" 0
    write "$core_ctl/busy_down_thres" 0
done

for cpuset in /dev/cpuset/*
do
    write "$cpuset/cpus" 0-1
    write "$cpuset/cpus" 0-2
    write "$cpuset/cpus" 0-3
    write "$cpuset/cpus" 0-4
    write "$cpuset/cpus" 0-5
    write "$cpuset/cpus" 0-6
    write "$cpuset/cpus" 0-7
    write "$cpuset/cpus" 0-8
    write "$cpuset/cpus" 0-9
    write "$cpuset/cpus" 0-10
    write "$cpuset/cpus" 0-11
done