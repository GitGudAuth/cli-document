#!/bin/bash
sleep 1
# Get the clipboard content using xclip
clipboard_content=$(xclip -selection clipboard -o)

# Debug: Print the clipboard content
#echo "Original clipboard content: $clipboard_content"

# Limit the clipboard content to a maximum of 50 characters using Bash substring expansion
clipboard_limited="${clipboard_content:0:50}"

# Debug: Print the limited clipboard content
#echo "Limited clipboard content: $clipboard_limited"

# Simulate typing the limited clipboard content
xdotool type --delay 50 "$clipboard_limited"
