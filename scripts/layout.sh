#!/bin/bash

layout() {
  dwm-msg get_monitors | jq '.[0].layout.symbol.current' | sed -e 's/^["'\'']//;s/["'\'']$//'
}

layout
dwm-msg --ignore-reply subscribe \
  tag_change_event \
  layout_change_event \
  client_focus_change_event \
  monitor_focus_change_event \
  focused_state_change_event | while read -r _; do layout; done

