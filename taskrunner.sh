#!/bin/bash
#
# Usage: ./taskrunner.sh <virtualization> <task>
#

INF_RESULT_FILE=./inference_results/"$1_inf_$2"

declare -A model_map
model_map["classify"]="yolov8n-cls.pt"
model_map["detect"]="yolov8n.pt"
model_map["segment"]="yolov8n-seg.pt"
model_map["pose"]="yolov8n-pose.pt"
model_map["obb"]="yolov8n-obb.pt"

model=${model_map[$2]}

yolo $2 predict model=${model} source=./images device=cpu 2>/dev/null | awk '$1 == "image" {print $1, $2, $NF}' >> ${INF_RESULT_FILE}

echo "<Inference statistics>"
stats=$(python3 cal_inf.py ${INF_RESULT_FILE})
echo "${stats}" >> ${INF_RESULT_FILE}
echo "${stats}"
echo ""
