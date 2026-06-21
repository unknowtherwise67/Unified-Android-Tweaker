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

# System Files Permissions
chmod 640 /sys/fs/selinux/enforce