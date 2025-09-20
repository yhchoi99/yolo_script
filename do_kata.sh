#!/bin/bash
#
# Usage: ./do_kata.sh
#

mkdir cpu_results 2>/dev/null
rm cpu_results/kata* 2>/dev/null

ssh root@172.17.0.2 "cd /yolo_script/; mkdir inference_results 2>/dev/null; rm inference_results/* 2>/dev/null"

tasks=("classify" "detect" "pose" "segment" "obb")

for task in "${tasks[@]}"; do
    echo "Start [[${task}]]"
    ./monitor.sh kata ${task} &
    ssh root@172.17.0.2 "export PATH=/usr/local/bin:$PATH; cd /yolo_script; ./taskrunner.sh kata ${task}"

    sleep 10   
done

echo "All tasks finished successfully!!"
