#!/bin/bash
#
# Usage: ./do_fc.sh
#

mkdir cpu_results 2>/dev/null
rm cpu_results/fc* 2>/dev/null

tasks=("classify" "detect" "pose" "segment" "obb")

ssh -i ubuntu-22.04.id_rsa root@172.16.0.2 "cd /yolo_script/; mkdir inference_results 2>/dev/null; rm inference_results/* 2>/dev/null"

for task in "${tasks[@]}"; do
    echo "Start [[${task}]]"
    ./monitor.sh fc ${task} &
    ssh -i ubuntu-22.04.id_rsa root@172.16.0.2 "export PATH=/usr/local/bin:$PATH; cd /yolo_script; ./taskrunner.sh fc ${task}"

    sleep 10   
done

echo "All tasks finished successfully!!"
