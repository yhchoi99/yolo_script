#!/bin/bash
#
# Usage: ./monitor.sh <virtualization> <task>
#

# Wait for YOLO preprocessing to complete.
sleep 20 

declare -A pname_map
pname_map["native"]="yolo"
pname_map["runc"]="yolo"
pname_map["vm"]="qemu-system-aar"
pname_map["fc"]="firecracker"
pname_map["kata"]="qemu-system-aar"

declare -A setting_map
setting_map["classify"]="TIME_SLICE=10; INTERVAL=0"
setting_map["detect"]="TIME_SLICE=30; INTERVAL=30"
setting_map["pose"]="TIME_SLICE=30; INTERVAL=30"
setting_map["segment"]="TIME_SLICE=40; INTERVAL=30"
setting_map["obb"]="TIME_SLICE=40; INTERVAL=30"

PNAME=${pname_map[$1]}
eval ${setting_map[$2]}
ITER=3	
sum=0

echo "Start CPU monitoring..."
for i in $(seq ${ITER})
do
	(pidstat -p $(pgrep ${PNAME}) ${TIME_SLICE} 1 >> ./cpu_results/"$1_pidstat_$2") &
    mpstat -P ALL ${TIME_SLICE} 1 >> ./cpu_results/"$1_mpstat_$2" 
    sleep ${INTERVAL} 
done
