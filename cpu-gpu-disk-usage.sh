#!/bin/bash

# CPU usage
cpu_percent=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $cpu_percent%"

# CPU temperature
cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
cpu_temp=$(echo "scale=2; $cpu_temp/1000" | bc)
echo "CPU Temperature: $cpu_temp°C"

# GPU usage 
gpu_percent=$(cat /sys/class/gpu/gpu0/utilization)
echo "GPU Usage: $gpu_percent%"

# Disk usage
root_disk_usage=$(df -h / | tail -1 | awk '{print $5}')
echo "Disk Usage: $root_disk_usage"
