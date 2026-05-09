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

# CPU Clocks/Frequencies
# This is Optional.
# If you want to change it you will have to do it by yourself.
# Since mobile hardware CPU and GPU clocks and frequencies are vary different.
# Most APUs and CPUs clocks and frequencies clusters are divided into 2, 3 or more depend on hardware configurations from OEMs/Manufactuers.
# Available Clocks/Frequencies can be located in this paths - /sys/devices/system/cpu/cpu*/cpufreq/ or /sys/devices/system/cpu/cpufreq/policy*.
# Note that CPU Clocks/Frequencies modification may not work and/or supported due to hardware sources codes limitations from OEMs/Manufactuers.
write /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq 
write /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq 
write /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq 

write /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq 
write /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq 
write /sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq 

# GPU Clocks/Frequencies
# This is Optional.
# Available Clocks/Frequencies can be located in this paths - /sys/class/kgsl/kgsl-3d0/devfreq/.
# Note that GPU Clocks/Frequencies modification may not work and/or supported due to hardware sources codes limitations from OEMs/Manufactuers.
write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 

# Device Charging Power
# This is Optional.
# Be sure to set the value correctly - For example: 1500000 = 1500 mAh = Around 5 and 6 Watt.
# Note that this modification may not/no longer work and/or supported, including newer Android Devices, due to hardware sources codes limitations from OEMs/Manufactuers.
# Get correct information about the device's max charging current value (Wattage or mAh).
# Otherwise, don't touch this parameters if you don't know about this.
chmod 666 /sys/class/power_supply/battery/constant_charge_current_max
write /sys/class/power_supply/battery/constant_charge_current_max 
chmod 444 /sys/class/power_supply/battery/constant_charge_current_max 