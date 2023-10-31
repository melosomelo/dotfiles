function toggle_keyboard_layout
  if test -n "$KEYBOARD_LAYOUT" -a "$KEYBOARD_LAYOUT" = "us-intl"
    setxkbmap -layout us
    set -U KEYBOARD_LAYOUT "us"
  else
    setxkbmap -layout us -variant intl
    set -U KEYBOARD_LAYOUT "us-intl"
  end
end
