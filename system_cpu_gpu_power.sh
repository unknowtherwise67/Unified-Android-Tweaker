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

# NOTE:
# THIS PARAMETERS IS COMPLETELY OPTIONAL.
# DON'T TOUCH/MODIFY THE PARAMETERS IF YOU DON'T KNOW ABOUT IT.
# For CPU/GPU Clocks/Frequencies Speed Modification:
# Most APUs and CPUs clocks and frequencies speed clusters are divided into 2, 3 or more depends on hardware configurations from OEMs/Manufactuers.
# Available CPU Clocks/Frequencies can be located in this paths - /sys/devices/system/cpu/cpu*/cpufreq/ or /sys/devices/system/cpu/cpufreq/policy*.
# Available GPU Clocks/Frequencies can be located in this paths - /sys/class/kgsl/kgsl-3d0/devfreq/.
# System Kernel will and should correct the value itseft if wrong value is detected and only work on CPU Clocks/Frequencies Speed.
# Note that CPU/GPU Clocks/Frequencies Speed modification may not work and/or supported due to hardware sources codes limitations from OEMs/Manufactuers.
# For Device Charging Power Modification:
# Be sure to set the value correctly - For example: 1500000 = 1500 mAh = Around 5 and 6 Watt.
# Note that this modification may not/no longer work and/or supported, including newer Android Devices, due to hardware sources codes limitations from OEMs/Manufactuers.
# Get correct information about the device's max charging current value (Wattage or mAh).
write /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq 
write /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq 
write /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq 

write /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq 
write /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq 
write /sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq 

write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 
write /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq 

write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 
write /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq 

write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq

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

write /sys/class/power_supply/battery/constant_charge_current_max