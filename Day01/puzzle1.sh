#!/bin/bash

input=$(cat "input.txt")
dial=50
dial_at_zero=0

turn_left() {
  local rotation=$1
  while [ $rotation -ne 0 ]; do
    dial=$((dial - 1))
    rotation=$((rotation - 1))
    if [ $dial -lt 0 ]; then
      dial=99
    fi
    if [ $rotation -eq 0 ]; then
      break
    fi
    if [ $dial -eq 0 ]; then
      dial_at_zero=$((dial_at_zero + 1))
    fi
  done
}

turn_right() {
  local rotation=$1
  while [ $rotation -ne 0 ]; do
    dial=$((dial + 1))
    rotation=$((rotation - 1))
    if [ $dial -gt 99 ]; then
      dial=0
    fi
     if [ $rotation -eq 0 ]; then
      break
    fi
    if [ $dial -eq 0 ]; then
      dial_at_zero=$((dial_at_zero + 1))
    fi
  done
}

for move in $input; do
  if [[ $move == L* ]]; then
    turn_left ${move#L}
  fi
  if [[ $move == R* ]]; then
    turn_right ${move#R}
  fi
  if [[ $dial -eq 0 ]]; then
    dial_at_zero=$((dial_at_zero + 1))
  fi
done

echo "$dial_at_zero"
