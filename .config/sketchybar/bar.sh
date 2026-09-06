#!/bin/bash

bar=(
  position=top
  height=29
  margin=0
  y_offset=0
  #corner_radius="$CORNER_RADIUS"
  #border_color="0x00ffffff"
  #border_width=2
  #blur_radius=20
  #color="$BAR_COLOR"
)

sketchybar --bar "${bar[@]}"
