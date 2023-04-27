# dhcpoffer
Edits DHCPOFFER headers and replays the packet on a specified interface.

Tested on Ubuntu 22.04 LTS.  Unsure if this works on other distro's, unless they have the `ip` command available.  The script uses `ip address` command to collect source MAC and IP address information.

The source MAC and IP address are updated inside the DHCPOFFER eth and ip headers.

The script then uses tcpreplay to loop the edited pcap 50 times with an interval of 200ms to avoid any potential broadcast storm protection mechanisms on the specified interface.

Dependencies:
- tcpreplay
- bittwist

Usage:
./dhcpoffer.sh [interface_name]
