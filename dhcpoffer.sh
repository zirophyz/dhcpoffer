#!/bin/bash

path=/home/labauto/resource
interface=$1
srcip=$(ip address show $interface | grep "inet " | awk '{print $2}' | cut -f1 -d'/')
srcmac=$(ip address show $interface | grep "link/ether " | awk '{print $2}')
fn="dhcpoffer-$(echo $srcmac | tail -c 8 | sed 's/://g').pcap"

echo ""
echo "Creating pcap file with MAC address" $srcmac "and IP address" $srcip
echo ""
echo ""
echo ""

# Output temp pcap with edited src MAC address
bittwiste -I $path/dhcpoffer.pcap -O $path/dhcpoffer-temp.pcap -T eth -s $srcmac &> /dev/null

sleep 0.2

# Output final pcap file containing edited src MAC and src IP
bittwiste -I $path/dhcpoffer-temp.pcap -O $path/$fn -T ip -s $srcip &> /dev/null

echo "Pcap file created."
echo "File is located at" $path"/"$fn
echo ""
echo ""
echo ""

sleep 0.2

# Clean up temp files
rm $path/dhcpoffer-temp.pcap

sleep 0.2

echo "Starting packet replay on" $interface", looping 50 times"
echo ""
# Start playing created pcap on interface specified
sudo tcpreplay -i $interface --loop=50 --loopdelay-ms=200 $path/$fn

echo ""
echo "Test completed."
echo ""

rm $path/$fn
