#!/bin/bash
# kubectl-kubeplugin — плагін для kubectl
# Виводить статистику CPU/Memory для Pod’ів або Node’ів у вигляді таблиці

NAMESPACE=$1
RESOURCE_TYPE=${2:-pods}

if [ -z "$NAMESPACE" ]; then
  echo "⚠️ Використання: kubectl kubeplugin <namespace> [pods|nodes]"
  exit 1
fi

echo "Resource  Namespace       Name                           CPU   Memory"

# Виклик metrics-server через kubectl top
kubectl top $RESOURCE_TYPE -n "$NAMESPACE" 2>/dev/null | tail -n +2 | while read line; do
  NAME=$(echo $line | awk '{print $1}')
  CPU=$(echo $line | awk '{print $2}')
  MEMORY=$(echo $line | awk '{print $3}')
  printf "%-8s %-14s %-30s %-5s %-7s\n" "$RESOURCE_TYPE" "$NAMESPACE" "$NAME" "$CPU" "$MEMORY"
done
