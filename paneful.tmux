#!/usr/bin/env bash

default_pane_resize="5"

get_tmux_option() {
    local option=$1
    local default_value=$2
    local option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

window_move_bindings() {
    tmux bind-key -r "<" swap-window -d -t -1
    tmux bind-key -r ">" swap-window -d -t +1
}

pane_resizing_bindings() {
    local pane_resize=$(get_tmux_option "@pane_resize" "$default_pane_resize")
    tmux bind-key -r M-Left resize-pane -L "$pane_resize"
    tmux bind-key -r M-Down resize-pane -D "$pane_resize"
    tmux bind-key -r M-Up resize-pane -U "$pane_resize"
    tmux bind-key -r M-Right resize-pane -R "$pane_resize"
}

pane_split_bindings() {
    tmux bind-key "|" split-window -h -c "#{pane_current_path}"
    tmux bind-key "\\" split-window -fh -c "#{pane_current_path}"
    tmux bind-key "-" split-window -v -c "#{pane_current_path}"
    tmux bind-key "_" split-window -fv -c "#{pane_current_path}"
}

pane_swap_bindings() {
    tmux bind-key -r C-M-Left swap-pane -L
    tmux bind-key -r C-M-Down swap-pane -D
    tmux bind-key -r C-M-Up swap-pane -U
    tmux bind-key -r C-M-Right swap-pane -R
}

main() {
    window_move_bindings
    pane_resizing_bindings
    pane_split_bindings
    pane_swap_bindings
}
main