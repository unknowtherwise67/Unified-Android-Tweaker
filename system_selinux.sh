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

# SELinux
# Change SELinux mode to Enforcing (1) or Permissive (0).
# Edit it with your own risk, as setting it to 0 will disable SELinux security policies.
# While it can solve some issues with Root and Root Modules of Android System.
# It may not work on some Android devices, as some of them are SELinux hardened to Enforcing by default.
write /sys/fs/selinux/enforce 