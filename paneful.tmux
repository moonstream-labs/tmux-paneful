#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_pane_resize="5"

source "$CURRENT_DIR/scripts/helpers.sh"

pane_navigation_bindings() {
    # Remove default navigation bindings
    tmux unbind-key h
    tmux unbind-key j
    tmux unbind-key k
    tmux unbind-key l
    tmux unbind-key C-h
    tmux unbind-key C-j
    tmux unbind-key C-k
    tmux unbind-key C-l
}

window_move_bindings() {
    tmux bind-key "<" swap-window -d -t -1
    tmux bind-key ">" swap-window -d -t +1
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
    tmux bind-key -r S-Left swap-pane -L
    tmux bind-key -r S-Down swap-pane -D
    tmux bind-key -r S-Up swap-pane -U
    tmux bind-key -r S-Right swap-pane -R
}

main() {
    pane_navigation_bindings
    window_move_bindings
    pane_resizing_bindings
    pane_split_bindings
    pane_swap_bindings
}

main