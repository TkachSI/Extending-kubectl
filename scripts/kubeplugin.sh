#!/bin/bash

# Define command-line arguments

RESOURCE_TYPE=$1

printf "%-10s %-15s %-30s %-10s %-10s\n" "Resource" "Namespace" "Name" "CPU" "Memory"

# Retrieve resource usage statistics from Kubernetes
kubectl top pods -n $RESOURCE_TYPE | tail -n +2 | while read line
do
  # Extract CPU and memory usage from the output
  NAME=$(echo $line | awk '{print $1}')
  CPU=$(echo $line | awk '{print $2}')
  MEMORY=$(echo $line | awk '{print $3}')

  # Output the statistics to the console
  # "Resource, Namespace, Name, CPU, Memory"
  printf "%-10s %-15s %-30s %-10s %-10s\n" "Pod" "$RESOURCE_TYPE" "$NAME" "$CPU" "$MEMORY"

done
