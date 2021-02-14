#""
#"❯"
#"▶"
#"〉"
#"》"
#""
#"❮"
#"◀"
#"〈"
#"《"
TMUX_STATUS_LINE_SEPARATOR_LEFT=""
TMUX_STATUS_LINE_SEPARATOR_LEFT_THIN="〈"
TMUX_STATUS_LINE_SEPARATOR_RIGHT=""
TMUX_STATUS_LINE_SEPARATOR_RIGHT_THIN="〉"

print_separator() {
    local figure=$1
    local separator_color=$2
    local bg_color=$3

    local style=direction
    echo "#[fg=${separator_color},bg=${bg_color}]$figure#[default]"
}

print_left_sparator() {
    local figure=$TMUX_STATUS_LINE_SEPARATOR_RIGHT
    local separator_color=$1
    local bg_color=$2
    local is_thin=$3
    # thin指定なら記号変更

    echo $(print_separator $figure $separator_color $bg_color)
}

print_rignt_sparator() {
    local figure=$TMUX_STATUS_LINE_SEPARATOR_LEFT
    local separator_color=$1
    local bg_color=$2
    local is_thin=$3
    # thin指定なら記号変更

    echo $(print_separator $figure $separator_color $bg_color)
}

main() {
    local style=$1
    local color=white
    local bg_color=$2
    local next_bg_color=$3

    echo "#[fg=$color,bg=${bg_color}]$style#[default]$(print_left_sparator  $bg_color $next_bg_color)"
}

# left right判定 $1
echo $(main "session [#S]" red blue)
#echo $(rignt_sparator  red blue)
