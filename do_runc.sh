#!/bin/bash
#
# Usage: ./do_runc.sh
#

container_name="yolo-runc"

do_taskrunner() {
  ./monitor.sh runc $1 &
  sudo docker exec $container_name /bin/bash -c "cd /yolo_script; ./taskrunner.sh runc $1"
  sudo docker stop $container_name >/dev/null 2>&1
}

mkdir cpu_results 2>/dev/null
rm cpu_results/runc* 2>/dev/null

INF_RESULT_PATH=/yolo_script/inference_results

sudo docker start $container_name >/dev/null 2>&1
sudo docker exec $container_name /bin/bash -c "mkdir $INF_RESULT_PATH >/dev/null 2>&1; rm -rf $INF_RESULT_PATH/* >/dev/null 2>&1"
sudo docker stop $container_name >/dev/null 2>&1
sleep 10

tasks=("classify" "detect" "pose" "segment" "obb")

for task in "${tasks[@]}"; do
  sudo docker start $container_name >/dev/null 2>&1
  echo "Start [[${task}]]"
  do_taskrunner ${task}
  sleep 10
done

echo "All tasks finished successfully!!"
