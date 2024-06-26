#!/usr/bin/env bash

# Grab global variable for showing datetime widget, only hide if explicitly disabled
SHOW_DATETIME=$(tmux show-option -gv @tokyo-night-tmux_show_datetime 2>/dev/null)
SHOW_DATE=$(tmux show-option -gv @tokyo-night-tmux_show_date 2>/dev/null)
SHOW_TIME=$(tmux show-option -gv @tokyo-night-tmux_show_time 2>/dev/null)

if [[ "$SHOW_DATETIME" == "0" ]]; then
  exit 0
fi

# Assign values based on user config
date_format=$(tmux show-option -gv @tokyo-night-tmux_date_format 2>/dev/null)
time_format=$(tmux show-option -gv @tokyo-night-tmux_time_format 2>/dev/null)

date_string=""
time_string=""

if [[ "$date_format" == "YMD" ]]; then
  # Year Month Day date format
  date_string="%Y-%m-%d"
elif [[ "$date_format" == "MDY" ]]; then
  # Month Day Year date format
  date_string="%m-%d-%Y"
elif [[ "$date_format" == "DMY" ]]; then
  # Day Month Year date format
  date_string="%d-%m-%Y"
else
  # Default to YMD date format if not specified
  date_string="%Y-%m-%d"
fi

if [[ "$time_format" == "12H" ]]; then
    # 12-hour format with AM/PM
    time_string="%I:%M %p"
else
    # Default to 24-hour format if not specified
    time_string="%H:%M"
fi

output_string=""
if [[ "$SHOW_DATE" == "0"  && "$SHOW_TIME" == 0 ]]; then
  exit 0
elif [[ "$SHOW_DATE" == "0" ]]; then
  output_string="#[fg=#a9b1d6,bg=#24283B] $time_string "
elif [[ "$SHOW_TIME" == "0" ]]; then
  output_string="#[fg=#a9b1d6,bg=#24283B] $date_string "
else
  output_string="#[fg=#a9b1d6,bg=#24283B] $date_string #[]❬ $time_string "
fi

echo "$output_string"
