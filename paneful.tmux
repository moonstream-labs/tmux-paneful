#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_pane_resize="5"

source "$CURRENT_DIR/scripts/helpers.sh"

pane_navigation_bindings() {
    # We'll keep these unbound as they might conflict with other uses
    tmux unbind-key M-h
    tmux unbind-key M-j
    tmux unbind-key M-k
    tmux unbind-key M-l
}

window_move_bindings() {
    tmux bind-key -r M-, swap-window -d -t -1
    tmux bind-key -r M-. swap-window -d -t +1
}

pane_resizing_bindings() {
    local pane_resize=$(get_tmux_option "@pane_resize" "$default_pane_resize")
    tmux bind-key -r M-H resize-pane -L "$pane_resize"
    tmux bind-key -r M-J resize-pane -D "$pane_resize"
    tmux bind-key -r M-K resize-pane -U "$pane_resize"
    tmux bind-key -r M-L resize-pane -R "$pane_resize"
}

pane_split_bindings() {
    tmux bind-key M-| split-window -h -c "#{pane_current_path}"
    tmux bind-key M-\\ split-window -fh -c "#{pane_current_path}"
    tmux bind-key M-- split-window -v -c "#{pane_current_path}"
    tmux bind-key M-_ split-window -fv -c "#{pane_current_path}"
}

pane_swap_bindings() {
    tmux bind-key -r M-Left swap-pane -L
    tmux bind-key -r M-Down swap-pane -D
    tmux bind-key -r M-Up swap-pane -U
    tmux bind-key -r M-Right swap-pane -R
}

main() {
    pane_navigation_bindings
    window_move_bindings
    pane_resizing_bindings
    pane_split_bindings
    pane_swap_bindings
}

main