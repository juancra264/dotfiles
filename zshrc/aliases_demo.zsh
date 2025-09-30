# System shortcuts
alias python="python3"
alias ls="eza"
alias ws_start="tmux has-session -t ws 2>/dev/null || tmux new-session -d -s ws"
alias ws="tmux a -t ws"

# Apps shortcuts
alias pingmon="python ~/nettools/pingmon/pingmon.py"
alias macvendor="bash ~/nettools/macvendor/macvendor.sh"
alias macadd="bash ~/nettools/macadd/macadd.sh"
alias checknet="bash ~/nettools/checknet/checknet.sh"
alias ipaddinfo="bash ~/nettools/ipaddinfo/ipaddinfo.sh"

# Serial shortcuts
alias serial0="picocom -b 9600 -r -l /dev/ttyUSB0"
alias serial1="picocom -b 9600 -r -l /dev/ttyUSB1"
alias serial2="picocom -b 115200 -r -l /dev/ttyUSB2"
alias serial3="picocom -b 9600 -r -l /dev/ttyUSB3"