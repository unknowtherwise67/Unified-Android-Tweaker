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

# Schedulers
KVER=$(uname -r)
K_MAJ=$(echo "$KVER" | cut -d. -f1)
K_MIN=$(echo "$KVER" | cut -d. -f2)
K_NUM=$((K_MAJ * 100 + K_MIN))

API_LEVEL=$(getprop ro.build.version.sdk 2>/dev/null)
[ -z "$API_LEVEL" ] && API_LEVEL=0

NCPU=$(nproc 2>/dev/null)
[ -z "$NCPU" ] && NCPU=8
ALL_CPU_MASK=$((1))
i=0
while [ "$i" -lt "$NCPU" ]; do
	ALL_CPU_MASK=$((ALL_CPU_MASK * 2))
	i=$((i + 1))
done
ALL_CPU_MASK=$((ALL_CPU_MASK - 1))
[ "$ALL_CPU_MASK" -le 0 ] && ALL_CPU_MASK="255"

for sched in /proc/sys/kernel /sys/kernel/debug /sys/kernel/debug/sched
do
	write "$sched/sched_task_unfilter_period" 200000000
	write "$sched/sched_latency_ns" 6000000
	write "$sched/sched_min_granularity_ns" 1500000
	write "$sched/sched_wakeup_granularity_ns" 1000000
	write "$sched/sched_short_burst_ns" 4000000
	write "$sched/sched_short_sleep_ns" 1500000
	write "$sched/sched_migration_cost_ns" 500000
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
	write "$sched/sched_rt_runtime_us" 950000
	write "$sched/sched_rr_timeslice_us" 50000
	write "$sched/sched_rr_timeslice_ms" 50
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
	write "$sched/sched_spill_nr_run" 3
	write "$sched/sched_asym_cap_sibling_freq_match_pct" 70
	write "$sched/sched_upmigrate" 45
	write "$sched/sched_downmigrate" 25
	write "$sched/sched_group_upmigrate" 45
	write "$sched/sched_group_downmigrate" 25
	write "$sched/sched_walt_init_task_load_pct" 50
	write "$sched/sched_init_task_load" 50
	write "$sched/sched_initial_task_util" 128
	write "$sched/sched_many_wakeup_threshold" 10
	write "$sched/sched_walt_cpu_high_irqload" 10
	write "$sched/sched_big_waker_task_load" 10
	write "$sched/sched_restrict_cluster_spill" 0
	write "$sched/sched_force_lb_enable" 1
	write "$sched/sched_prefer_spread" 1
	write "$sched/sched_coloc_busy_hyst_ns" 50000000
	write "$sched/sched_coloc_busy_hysteresis_enable_cpus" "$ALL_CPU_MASK"
	write "$sched/sched_coloc_busy_hyst_max_ms" 30
	write "$sched/sched_assist_scenes" 255
	write "$sched/sched_assist_enabled" 1
	write "$sched/sched_assist_ux_uclamp_max_enable" 1
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
	write "$sched/sched_schedstats" 0
	write "$sched/sched_autogroup_enabled" 1
	write "$sched/sched_is_big_little" 1
	write "$sched/sched_use_walt_task_util" 2
	write "$sched/sched_use_walt_cpu_util" 1
	write "$sched/sched_wake_to_idle" 1
	write "$sched/sched_small_wakee_task_load" 0
	write "$sched/sched_child_runs_first" 1
	write "$sched/sched_dynamic_ravg_window_enable" 0
	if [ "$K_NUM" -ge 606 ]; then
		write "$sched/base_slice_ns" 3000000
	fi
done

for walt_dir in /proc/sys/walt /sys/module/walt/parameters /sys/kernel/walt
do
	write "$walt_dir/sched_upmigrate" 45
	write "$walt_dir/sched_downmigrate" 25
	write "$walt_dir/sched_group_upmigrate" 45
	write "$walt_dir/sched_group_downmigrate" 25
	write "$walt_dir/sched_walt_init_task_load_pct" 50
	write "$walt_dir/sched_walt_rotate_big_tasks" 1
	write "$walt_dir/sched_coloc_busy_hyst_ns" 50000000
done

for vnd_dir in /proc/sys/oplus_scheduler/sched_assist /sys/module/oplus_bsp_task_sched/parameters /sys/module/mtk_core_pause/parameters
do
	write "$vnd_dir/sched_assist_enabled" 1
	write "$vnd_dir/sched_assist_scenes" 255
	write "$vnd_dir/sched_assist_ux_uclamp_max_enable" 1
done

for sf in /sys/kernel/debug/sched_features /sys/kernel/sched_features
do
	write "$sf" NO_GENTLE_FAIR_SLEEPERS
	write "$sf" NO_HRTICK
	write "$sf" NO_DOUBLE_TICK
	write "$sf" NO_RT_RUNTIME_SHARE
	write "$sf" NO_NEXT_BUDDY
	write "$sf" NO_LAST_BUDDY
	write "$sf" NO_TTWU_QUEUE
	write "$sf" NO_UTIL_EST
	write "$sf" NO_ARCH_CAPACITY
	write "$sf" NO_ARCH_POWER
	write "$sf" NO_START_DEBIT
	write "$sf" NO_CACHE_HOT_BUDDY
	write "$sf" NO_WAKEUP_PREEMPTION
	write "$sf" NO_LB_BIAS
	write "$sf" NO_NONTASK_CAPACITY
	write "$sf" NO_RT_PUSH_IPI
	write "$sf" NO_FORCE_SD_OVERLAP
	write "$sf" NO_LB_MIN
	write "$sf" NO_ATTACH_AGE_LOAD
	write "$sf" NO_SIS_AVG_CPU
	write "$sf" NO_MIN_CAPACITY_CAPPING
	write "$sf" NO_FBT_STRICT_ORDER
	write "$sf" NO_EAS_USE_NEED_IDLE
	write "$sf" NO_ENERGY_AWARE
	write "$sf" NO_SCHED_HMP
	write "$sf" NO_SCHED_MTK_EAS
	if [ "$K_NUM" -ge 606 ]; then
		write "$sf" EEVDF
		write "$sf" WAKEUP_PREEMPTION
	fi
done

# CPU/GPU/IO
for governor in /sys/*/system/cpu/*/cpufreq/* /sys/*/system/cpu/cpufreq/*
do
    write "$governor/boost" 1
    write "$governor/pl" 1
    write "$governor/io_is_busy" 1
    write "$governor/iowait_boost_enable" 1
    write "$governor/fastlane" 1
    write "$governor/fast_ramp_down" 0
    write "$governor/boostpulse" 1
    write "$governor/use_sched_load" 1
    write "$governor/use_migration_notif" 1
    write "$governor/enable_prediction" 1
    write "$governor/align_windows" 1
    write "$governor/ignore_nice_load" 1
    write "$governor/input_boost" 1
    write "$governor/enforced_mode" 1
    write "$governor/timer_slack" -1
    write "$governor/freq_step" 15
    write "$governor/target_load_shift" 5
    write "$governor/sched_upmigrate_min_nice" -5
    write "$governor/down_differential" 45
    write "$governor/up_threshold" 45
    write "$governor/go_hispeed_load" 50
    write "$governor/hispeed_load" 50
    write "$governor/target_loads" "50 1200000:60 1600000:70 1800000:80"
    write "$governor/single_enter_load" 45
    write "$governor/single_exit_load" 85
    write "$governor/up_threshold_any_cpu_load" 50
    write "$governor/target_load_thresh" 50
    write "$governor/multi_enter_load" 75
    write "$governor/multi_exit_load" 90
    write "$governor/input_boost_ms" 150
    write "$governor/boost_ms" 250
    write "$governor/single_enter_time" 1000
    write "$governor/timer_rate" 2500
    write "$governor/sampling_rate" 2500
    write "$governor/sampling_rate_min" 2500
    write "$governor/up_rate_limit_us" 500
    write "$governor/down_rate_limit_us" 15000
    write "$governor/single_exit_time" 40000
    write "$governor/multi_enter_time" 2000
    write "$governor/above_hispeed_delay" "0 1200000:10000 1800000:15000"
    write "$governor/sched_freq_inc_notify" 10000
    write "$governor/multi_exit_time" 40000
    write "$governor/min_sample_time" 20000
    write "$governor/boostpulse_duration" 250000
    write "$governor/sched_freq_dec_notify" 200000
    write "$governor/up_throttle_nsec" 1000000
    write "$governor/down_throttle_nsec" 4000000
done

write /sys/kernel/gpu/boost 1
write /proc/mali/always_on 1
write /proc/mali/dvfs_enable 1
write /sys/module/ged/parameters/gpu_dvfs_enable 1
write /sys/class/kgsl/kgsl-3d0/force_bus_on 1
write /sys/class/kgsl/kgsl-3d0/force_clk_on 1
write /sys/class/kgsl/kgsl-3d0/force_rail_on 1
write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 3
write /sys/kernel/debug/sde_rotator0/clk_always_on 1
write /sys/module/mali/parameters/mali_touch_boost_level 1
write /sys/class/simple_gpu_algorithm/parameters/simple_gpu_active 1
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/vsync 1
write /sys/module/adreno_idler/parameters/adreno_idler_idlewait 10
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/vsync_downdifferential 50
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/no_vsync_upthreshold 10
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/vsync_upthreshold 10
write /sys/class/kgsl/kgsl-3d0/devfreq/gpufreq/mali_ondemand/no_vsync_downdifferential 50
write /sys/module/adreno_idler/parameters/adreno_idler_downdifferential 50
write /sys/module/adreno_idler/parameters/adreno_idler_idleworkload 10000
write /sys/class/simple_gpu_algorithm/parameters/simple_ramp_threshold 5000
write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 0
write /sys/class/kgsl/kgsl-3d0/max_pwrlevel 0
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 0
write /sys/class/kgsl/kgsl-3d0/thermal_pwrlevel 0
write /sys/class/kgsl/kgsl-3d0/tmu 0
write /sys/class/kgsl/kgsl-3d0/popp 0
write /sys/class/kgsl/kgsl-3d0/pwrnap 0
write /sys/class/simple_gpu_algorithm/parameters/simple_laziness 0
write /sys/module/adreno_idler/parameters/adreno_idler_active N
write /sys/devices/platform/13040000.mali/power_policy always_on
write /sys/class/kgsl/kgsl-3d0/power_policy always_on

for pwrlevel in /sys/class/kgsl/kgsl-3d0/min_pwrlevel /sys/class/kgsl/kgsl-3d0/default_pwrlevel
do
    write "$pwrlevel" 1
    write "$pwrlevel" 2
    write "$pwrlevel" 3
    write "$pwrlevel" 4
    write "$pwrlevel" 5
    write "$pwrlevel" 6
    write "$pwrlevel" 7
    write "$pwrlevel" 8
    write "$pwrlevel" 9
    write "$pwrlevel" 10
    write "$pwrlevel" 11
    write "$pwrlevel" 12
    write "$pwrlevel" 13
    write "$pwrlevel" 14
    write "$pwrlevel" 15
    write "$pwrlevel" 16
    write "$pwrlevel" 17
    write "$pwrlevel" 18
    write "$pwrlevel" 19
    write "$pwrlevel" 20
    write "$pwrlevel" 21
    write "$pwrlevel" 22
    write "$pwrlevel" 23
    write "$pwrlevel" 24
    write "$pwrlevel" 25
    write "$pwrlevel" 26
    write "$pwrlevel" 27
    write "$pwrlevel" 28
    write "$pwrlevel" 29
    write "$pwrlevel" 30
done

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
    write "$stune/schedtune.capacity.min" 100
    write "$stune/schedtune.cpucapacity.min" 100
    write "$stune/schedtune.uclamp.min.effective" 100
    write "$stune/cpu.cpucapacity_min" 100
    write "$stune/cpu.uclamp.max.effective" 100
    write "$stune/cpu.uclamp.min" 100
    write "$stune/cpu.uclamp" 100
    write "$stune/cpu_uclamp.min" 100
    write "$stune/cpu_uclamp.min.effective" 100
    write "$stune/cpu.uclamp.max" 100
    write "$stune/cpu.uclamp.max.effective" 100
    write "$stune/schedtune.capacity_min" 100
    write "$stune/schedtune.cpucapacity_min" 100
    write "$stune/schedtune.uclamp.min_effective" 100
    write "$stune/cpu.cpucapacity_min" 100
    write "$stune/cpu.uclamp_max_effective" 100
    write "$stune/cpu.uclamp_min" 100
    write "$stune/cpu.uclamp" 100
    write "$stune/cpu_uclamp_min" 100
    write "$stune/cpu_uclamp_min.effective" 100
    write "$stune/cpu.uclamp_max" 100
    write "$stune/cpu.uclamp_max_effective" 100
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

# Memory
MEM_KB=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
[ -z "$MEM_KB" ] && MEM_KB=4194304
RAM_GB=$(( (MEM_KB + 524288) / 1048576 ))
[ "$RAM_GB" -lt 1 ] && RAM_GB=1
[ "$RAM_GB" -gt 128 ] && RAM_GB=128
ZRAM_BYTES=$(( MEM_KB * 1024 ))
if [ "$RAM_GB" -le 2 ]; then
    SWAPPINESS=120
    VFS_CACHE_PRESSURE=100
    MIN_FREE_KB=$(( RAM_GB * 8192 ))
    EXTRA_FREE_KB=$(( RAM_GB * 8192 ))
    WM_SCALE=150
    DIRTY_BG=3
    DIRTY_MAX=10
elif [ "$RAM_GB" -le 8 ]; then
    SWAPPINESS=100
    VFS_CACHE_PRESSURE=100
    MIN_FREE_KB=$(( RAM_GB * 4096 ))
    EXTRA_FREE_KB=$(( RAM_GB * 6144 ))
    WM_SCALE=125
    DIRTY_BG=3
    DIRTY_MAX=12
elif [ "$RAM_GB" -le 32 ]; then
    SWAPPINESS=80
    VFS_CACHE_PRESSURE=90
    MIN_FREE_KB=$(( RAM_GB * 3072 ))
    EXTRA_FREE_KB=$(( RAM_GB * 4096 ))
    WM_SCALE=100
    DIRTY_BG=2
    DIRTY_MAX=10
else
    SWAPPINESS=60
    VFS_CACHE_PRESSURE=80
    MIN_FREE_KB=$(( RAM_GB * 2048 ))
    EXTRA_FREE_KB=$(( RAM_GB * 3072 ))
    WM_SCALE=75
    DIRTY_BG=2
    DIRTY_MAX=10
fi
[ "$MIN_FREE_KB" -lt 4096 ] && MIN_FREE_KB=4096
[ "$MIN_FREE_KB" -gt 262144 ] && MIN_FREE_KB=262144
[ "$EXTRA_FREE_KB" -lt 4096 ] && EXTRA_FREE_KB=4096
[ "$EXTRA_FREE_KB" -gt 393216 ] && EXTRA_FREE_KB=393216
USER_RESERVE_KB=$(( MIN_FREE_KB / 2 ))
ADMIN_RESERVE_KB=$(( MIN_FREE_KB / 4 ))
OVERCOMMIT_FREE_KB=$(( MIN_FREE_KB * 2 ))
[ "$USER_RESERVE_KB" -lt 2048 ] && USER_RESERVE_KB=2048
[ "$ADMIN_RESERVE_KB" -lt 1024 ] && ADMIN_RESERVE_KB=1024
[ "$OVERCOMMIT_FREE_KB" -lt 8192 ] && OVERCOMMIT_FREE_KB=8192
write /proc/sys/vm/stat_interval 5
write /proc/sys/vm/overcommit_memory 1
write /proc/sys/vm/page-cluster 0
write /proc/sys/vm/dirty_background_ratio "$DIRTY_BG"
write /proc/sys/vm/dirty_ratio "$DIRTY_MAX"
write /proc/sys/vm/watermark_scale_factor "$WM_SCALE"
write /proc/sys/vm/overcommit_ratio 100
write /proc/sys/vm/vfs_cache_pressure "$VFS_CACHE_PRESSURE"
write /proc/sys/vm/swappiness "$SWAPPINESS"
write /proc/sys/vm/min_free_kbytes "$MIN_FREE_KB"
write /proc/sys/vm/extra_free_kbytes "$EXTRA_FREE_KB"
write /proc/sys/vm/user_reserve_kbytes "$USER_RESERVE_KB"
write /proc/sys/vm/admin_reserve_kbytes "$ADMIN_RESERVE_KB"
write /proc/sys/vm/overcommit_free_kbytes "$OVERCOMMIT_FREE_KB"
write /proc/sys/vm/dirty_expire_centisecs 2000
write /proc/sys/vm/dirty_writeback_centisecs 1000
write /sys/module/lowmemorykiller/parameters/minfree 0,0,0,0,0,0
write /proc/sys/vm/drop_caches 0
write /proc/sys/vm/laptop_mode 0
write /proc/sys/vm/oom_kill_allocating_task 0
write /sys/module/lowmemorykiller/parameters/oom_reaper 0
write /sys/module/lowmemorykiller/parameters/lmk_fast_run 0
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/process_reclaim/parameters/enable_process_reclaim 0

# Others parameters
write /sys/kernel/rcu_normal 0
write /sys/kernel/rcu_expedited 1
write /proc/sys/fs/leases-enable 1
write /proc/sys/fs/lease-break-time 2
write /proc/sys/fs/dir-notify-enable 1
write /proc/sys/dev/tty/ldisc_autoload 0
write /proc/sys/kernel/random/read_wakeup_threshold 256
write /proc/sys/kernel/random/write_wakeup_threshold 256
write /proc/sys/kernel/printk_devkmsg off
write /sys/module/workqueue/parameters/power_efficient 0
write /sys/module/sync/parameters/fsync_enabled 1
write /sys/kernel/dyn_fsync/Dyn_fsync_active 1
write /sys/kernel/tracing/events/sched/sched_boost_cpu/enable 1
write /sys/kernel/tracing/events/sched/sched_boost_cpu 1
write /sys/devices/system/cpu/sched/hint_enable 1
write /sys/module/system/cpu/sched_mc_power_savings 0
write /proc/cpufreq/cpufreq_power_mode 3
write /sys/module/battery_saver/parameters/enabled N
write /sys/module/pm2/parameters/idle_sleep_mode N
write /sys/module/lpm_levels/parameters/bias_hyst 0
write /sys/module/lpm_levels/parameters/lpm_prediction N
write /sys/module/lpm_levels/parameters/lpm_ipi_prediction N
write /sys/module/lpm_levels/parameters/sleep_disabled Y
write /sys/module/exynos_acme/parameters/enable_suspend_freqs N
write /sys/class/mmc_host/mmc0/clk_scaling/enable 0
write /sys/class/mmc_host/mmc1/clk_scaling/enable 0
write /sys/module/mmc_core/parameters/use_spi_crc 0
write /sys/module/mmc_core/parameters/removable N
write /sys/module/mmc_core/parameters/crc 0
write /sys/devices/platform/soc/1d84000.ufshc/clkscale_enable 0
write /sys/devices/platform/soc/1d84000.ufshc/hibern8_on_idle_enable 0
write /sys/devices/platform/soc/1d84000.ufshc/clkgate_enable 0
write /sys/kernel/oppo_display/LCM_CABC 0
write /proc/touchpanel/oplus_tp_direction 1
write /proc/touchpanel/game_switch_enable 1
write /proc/touchpanel/oplus_tp_limit_enable 0
write /proc/sys/kernel/slide_boost_enabled 1
write /proc/sys/kernel/launcher_boost_enabled 1
write /sys/kernel/fp_boost/enabled 1
write /sys/kernel/debug/msm_vidc/fw_low_power_mode 0
write /sys/kernel/mi_reclaim/enable 0
write /sys/class/sec/switch/afc_disable 1
write /sys/module/fast_charge/force_fast_charge 1
write /sys/kernel/fast_charge/force_fast_charge 1
write /sys/class/power_supply/battery/charging_enabled 1
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
write /sys/module/ged/parameters/enable_game_self_frc_detect 1
write /sys/module/ged/parameters/ged_boost_enable 1
write /sys/module/ged/parameters/gx_3D_benchmark_on 1
write /sys/module/ged/parameters/cpu_boost_policy 100
write /sys/module/ged/parameters/ged_smart_boost 100
write /sys/module/ged/parameters/gx_fb_dvfs_margin 100
write /sys/module/ged/parameters/gx_tb_dvfs_margin 0
write /sys/module/ged/parameters/target_t_cpu_remained 0
write /sys/module/ged/parameters/gpu_debug_enable 0
write /sys/module/ged/parameters/ged_force_mdp_enable 0
write /sys/module/ged/parameters/ged_log_perf_trace_enable 0
write /sys/module/ged/parameters/ged_log_trace_enable 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_debug 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_disable 0
write /sys/module/ged/parameters/ged_monitor_3D_fence_systrace 0
write /proc/perfmgr/tchbst/user/usrtch/enable 1
write /proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_enable 1
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_prefer_idle 1
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_fg_boost 1
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_ta_boost 1
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_bg_boost 1
write /proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_up_loading 30
write /proc/perfmgr/boost_ctrl/cpu_ctrl/cfp_down_loading 10
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_uclamp_min 1024
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_fg_uclamp_min 1024
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_ta_uclamp_min 1024
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_bg_uclamp_min 1024
write /sys/module/lpm_levels/parameters/secapp_sleep_disabled Y
write /sys/module/lpm_levels/parameters/system_sleep_disabled Y
write /sys/module/lpm_levels/parameters/cpu_sleep_disabled Y
write /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us 500
write /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us 500
write /sys/kernel/oppo_display/hbm 0
write /proc/touchpanel/oplus_tp_direction_limit 0
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_uclamp_max 1024
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_fg_uclamp_max 1024
write /proc/perfmgr/boost_ctrl/eas_ctrl/perfserv_ta_uclamp_max 1024

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