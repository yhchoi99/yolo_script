# YOLOv8 Benchmarks
This repository provides benchmarking scripts to evaluate the performance of various virtualization techniques when running computer vision tasks. 
We use five representative tasks provided by [Ultralytics](https://docs.ultralytics.com/tasks/).

## How to run
- Run `./do_<virtualization>.sh`
  - virtualization: `native`, `runc`, `vm` (i.e., KVM/QEMU), `fc` (i.e., Firecracker), `kata` (i.e., Kata container)
  - Internally, it runs all five tasks via `taskrunner.sh` and, in parallel, monitors CPU usage via `monitor.sh`.
  - Note: Before running this script, ensure the target instance is created, started, and initialized with all required packages(e.g., ultralytics, sysstat), datasets, and scripts.

## Other details
- `taskrunner.sh`
  - Usage: `./taskrunner.sh <virtualization> <task>`
  - Tasks: classification, object detection, image segmentation, pose estimation, oriented object detection 
  - Uses pretrained models for each task and outputs per-image predictions along with the inference time.
- `monitor.sh`
  - Monitors CPU usage using `pidstat` (target process) and `mpstat` (system-wide).
- `cal_inf.py`
  - Calculates the mean and standard deviation of the inference times.

## Versions
- ultralytics: 8.2.2
- torch: 2.2.2
- torchvision: 0.17.2
- opencv-python: 4.9.0.80

## Dataset
We use [COCO](https://cocodataset.org/) dataset in our experiments.
