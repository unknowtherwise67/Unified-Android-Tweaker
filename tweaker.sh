# Script Command
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

# Schedulers
write /proc/sys/kernel/printk_devkmsg off
write /proc/sys/kernel/sched_latency_ns 10000000
write /proc/sys/kernel/sched_min_granularity_ns 5000000
write /proc/sys/kernel/sched_wakeup_granularity_ns 5000000
write /proc/sys/kernel/sched_migration_cost_ns 5000000
write /proc/sys/kernel/sched_nr_migrate 4096
write /proc/sys/kernel/sched_schedstats 1
write /proc/sys/kernel/sched_autogroup_enabled 0
write /proc/sys/kernel/sched_child_runs_first 0
write /proc/sys/kernel/sched_tunable_scaling 0
write /proc/sys/kernel/sched_min_task_util_for_colocation 0
write /proc/sys/kernel/sched_util_clamp_min_rt_default 0
write /proc/sys/kernel/sched_energy_aware 0
write /proc/sys/kernel/sched_pelt_multiplier 0
write /proc/sys/kernel/sched_cfs_boost 0
write /proc/sys/kernel/sched_cstate_aware 0
write /proc/sys/kernel/sched_initial_task_util 0
write /proc/sys/kernel/sched_is_big_little 0
write /proc/sys/kernel/sched_use_walt_cpu_util 0
write /proc/sys/kernel/sched_use_walt_task_util 0
write /proc/sys/kernel/sched_sync_hint_enable 0
write /proc/sys/kernel/sched_wake_to_idle 0
write /proc/sys/kernel/sched_enable_thread_grouping 0
write /proc/sys/kernel/sched_restrict_cluster_spill 0
write /sys/kernel/debug/sched_features 0

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

# Memory
write /proc/sys/vm/dirty_background_ratio 75
write /proc/sys/vm/dirty_ratio 100
write /proc/sys/vm/dirty_expire_centisecs 3000
write /proc/sys/vm/dirty_writeback_centisecs 3000
write /proc/sys/vm/page-cluster 3
write /proc/sys/vm/stat_interval 10
write /proc/sys/vm/swappiness 100
write /proc/sys/vm/vfs_cache_pressure 100

# Schedtune Idles/Boosts/CPUs-Set
write /dev/stune/background/schedtune.boost 10
write /dev/stune/foreground/schedtune.boost 10
write /dev/stune/rt/schedtune.boost 10
write /dev/stune/top-app/schedtune.boost 10
write /dev/stune/schedtune.boost 10

write /dev/stune/background/schedtune.prefer_idle 1
write /dev/stune/foreground/schedtune.prefer_idle 1
write /dev/stune/rt/schedtune.prefer_idle 1
write /dev/stune/top-app/schedtune.prefer_idle 1
write /dev/stune/schedtune.prefer_idle 1

write /dev/cpuset/background/cpus 0-3
write /dev/cpuset/foreground/cpus 0-3
write /dev/cpuset/rt/cpus 0-3
write /dev/cpuset/top-app/cpus 0-3
write /dev/cpuset/cpus 0-3
write /dev/cpuset/application/cpus 0-3
write /dev/cpuset/system/cpus 0-3
write /dev/cpuset/system-background/cpus 0-3
write /dev/cpuset/kernel/cpus 0-3
write /dev/cpuset/camera-daemon/cpus 0-3
write /dev/cpuset/restricted/cpus 0-3

write /dev/cpuset/background/cpus 0-7
write /dev/cpuset/foreground/cpus 0-7
write /dev/cpuset/rt/cpus 0-7
write /dev/cpuset/top-app/cpus 0-7
write /dev/cpuset/cpus 0-7
write /dev/cpuset/application/cpus 0-7
write /dev/cpuset/system/cpus 0-7
write /dev/cpuset/system-background/cpus 0-7
write /dev/cpuset/kernel/cpus 0-7
write /dev/cpuset/camera-daemon/cpus 0-7
write /dev/cpuset/restricted/cpus 0-7

write /dev/cpuset/background/cpus 0-8
write /dev/cpuset/foreground/cpus 0-8
write /dev/cpuset/rt/cpus 0-8
write /dev/cpuset/top-app/cpus 0-8
write /dev/cpuset/cpus 0-8
write /dev/cpuset/application/cpus 0-8
write /dev/cpuset/system/cpus 0-8
write /dev/cpuset/system-background/cpus 0-8
write /dev/cpuset/kernel/cpus 0-8
write /dev/cpuset/camera-daemon/cpus 0-8
write /dev/cpuset/restricted/cpus 0-8

write /dev/cpuset/background/cpus 0-9
write /dev/cpuset/foreground/cpus 0-9
write /dev/cpuset/rt/cpus 0-9
write /dev/cpuset/top-app/cpus 0-9
write /dev/cpuset/cpus 0-9
write /dev/cpuset/application/cpus 0-9
write /dev/cpuset/system/cpus 0-9
write /dev/cpuset/system-background/cpus 0-9
write /dev/cpuset/kernel/cpus 0-9
write /dev/cpuset/camera-daemon/cpus 0-9
write /dev/cpuset/restricted/cpus 0-9

write /dev/cpuset/background/cpus 0-11
write /dev/cpuset/foreground/cpus 0-11
write /dev/cpuset/rt/cpus 0-11
write /dev/cpuset/top-app/cpus 0-11
write /dev/cpuset/cpus 0-11
write /dev/cpuset/application/cpus 0-11
write /dev/cpuset/system/cpus 0-11
write /dev/cpuset/system-background/cpus 0-11
write /dev/cpuset/kernel/cpus 0-11
write /dev/cpuset/camera-daemon/cpus 0-11
write /dev/cpuset/restricted/cpus 0-11

# Device/Others parameters
write /sys/module/msm_thermal/core_control/enabled 0
write /sys/module/workqueue/parameters/power_efficient N
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/lowmemorykiller/parameters/lmk_fast_run 0
write /sys/module/mmc_core/parameters/use_spi_crc 0
write /sys/module/system/cpu/sched_mc_power_savings 0
write /sys/module/fast_charge/force_fast_charge 1
write /proc/sys/kernel/random/read_wakeup_threshold 128
write /proc/sys/kernel/random/write_wakeup_threshold 128
write /sys/fs/selinux/enforce 1

settings put global development_settings_enabled 0
settings put global adb_enabled 0
settings put global window_animation_scale 1.00
settings put global transition_animation_scale 1.00
settings put global animator_duration_scale 1.00
settings put global settings_enable_monitor_phantom_procs false

wm disable-blur <value>
setprop ctl.stop mpdecision;stop mpdecision
setprop persist.sys.fflag.override.settings_enable_monitor_phantom_procs false
dumpsys deviceidle disable

# Thermal
write /sys/module/msm_thermal/core_control/enabled 0
write /sys/module/msm_thermal/vdd_restriction/enabled 0

# TCP
write /proc/sys/net/ipv4/tcp_ecn 1
write /proc/sys/net/ipv4/tcp_fastopen 3
write /proc/sys/net/ipv4/tcp_syncookies 0

# CPU/GPU/IO Memory Sheduler
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
	write "$governor/sampling_down_factor" 1
	write "$governor/ignore_hispeed_on_notif" 1
	write "$governor/io_is_busy" 1
	write "$governor/align_windows" 1
	write "$governor/hispeed_load" 75
	write "$governor/go_hispeed_load" 75
	write "$governor/up_threshold" 75
	write "$governor/target_load" 75
	write "$governor/above_hispeed_delay" 100000
	write "$governor/up_rate_limit_us" 10000
	write "$governor/down_rate_limit_us" 100000
	write "$governor/up_throttle_nsec" 100000
	write "$governor/down_throttle_nsec" 1000000
	write "$governor/boostpulse_duration" 100000
	write "$governor/timer_rate" 100000
	write "$governor/min_sample_time" 10000
	write "$governor/timer_slack" 100000
	write "$governor/sampling_rate" 100000
	write "$governor/sampling_rate_min" 1000000
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
	write "$governor/sampling_down_factor" 1
	write "$governor/ignore_hispeed_on_notif" 1
	write "$governor/io_is_busy" 1
	write "$governor/align_windows" 1
	write "$governor/hispeed_load" 75
	write "$governor/go_hispeed_load" 75
	write "$governor/up_threshold" 75
	write "$governor/target_load" 75
	write "$governor/above_hispeed_delay" 100000
	write "$governor/up_rate_limit_us" 10000
	write "$governor/down_rate_limit_us" 100000
	write "$governor/up_throttle_nsec" 100000
	write "$governor/down_throttle_nsec" 1000000
	write "$governor/boostpulse_duration" 100000
	write "$governor/timer_rate" 100000
	write "$governor/min_sample_time" 10000
	write "$governor/timer_slack" 100000
	write "$governor/sampling_rate" 100000
	write "$governor/sampling_rate_min" 1000000
done

write /sys/class/kgsl/kgsl-3d0/throttling 0
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 6
write /sys/class/simple_gpu_algorithm/parameters/simple_gpu_active 1
write /sys/class/simple_gpu_algorithm/parameters/simple_ramp_threshold 10000
write /sys/class/simple_gpu_algorithm/parameters/simple_laziness 0
write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 3
write /sys/class/kgsl/kgsl-3d0/force_bus_on 1
write /sys/class/kgsl/kgsl-3d0/force_clk_on 1
write /sys/class/kgsl/kgsl-3d0/force_rail_on 1

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
	write "$queue/add_random" 1
	write "$queue/rotational" 1
	write "$queue/iostats" 1
	write "$queue/rq_affinity" 2
	write "$queue/nomerges" 2
	write "$queue/read_ahead_kb" 128
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