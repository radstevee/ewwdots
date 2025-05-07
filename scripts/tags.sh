#!/bin/bash

tags() {
  TAGS=9
  FOCUSED=$(dwmc focusedtag)

  OUT='(box :class "bar-tags" :halign "start" :valign "center"'

  for ((tag = 1; tag <= TAGS; tag++)); do
    display=`eval "$(xdotool getmouselocation --shell)" && [[ "$X" -gt 1920 ]] && echo "0" || echo "1"`
    occ="$(dwm-msg get_monitors | jq ".[$display].tag_state.occupied")"
    isactive="$([[ $((occ & (1<<(tag-1)))) -ne 0 ]] && echo true || echo false)"

    if [[ "$FOCUSED" -eq "$tag" ]]; then
      CLASS="focused-tag focused-tag-$tag"
    elif [[ "$isactive" = true ]]; then
      CLASS="active-tag active-tag-$tag"
    else
      CLASS="tag-$tag"
    fi

    OUT+=" (button :onclick \"dwmc view $((tag - 1)) &\" :class \"tag $CLASS box text\" :width 32 :height 32 :valign \"center\" :halign \"start\" \"$tag\")"
  done

  OUT+=")"

  echo "$OUT"
}

tags
dwm-msg --ignore-reply subscribe \
  tag_change_event \
  layout_change_event \
  client_focus_change_event \
  monitor_focus_change_event \
  focused_state_change_event | while read -r _; do tags; done

