#!/bin/bash

title() {
  cid="$(dwm-msg get_monitors | jq '.[] | select(.is_selected == true) | .clients.selected')"
  if [ "$cid" -eq "0" ]; then
    echo ""
    return
  fi
  dwm-msg get_dwm_client "$cid" | jq '.name' -r
}

title
dwm-msg --ignore-reply subscribe \
  tag_change_event \
  layout_change_event \
  client_focus_change_event \
  monitor_focus_change_event \
  focused_state_change_event \
  focused_title_change_event | while read -r _; do title; done

