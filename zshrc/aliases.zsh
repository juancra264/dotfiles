# System shortcuts
alias sr='source ~/.zshrc'
#alias ls="exa --color=auto"
alias cat="bat --color=auto --plain"
alias grep="grep --color=auto"
alias vim="nvim"
alias commit="PRE_COMMIT_ALLOW_NO_CONFIG=1 git commit -m"

# GCP shortcuts:
alias gclist="gcloud compute instances list"

# AWS shortcuts
alias ec2list="aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{Instance:InstanceId,PublicIPAddress:PublicIpAddress}'"

# Serial (picocom) shortcuts
alias pico="picocom -b 9600 -r -l /dev/tty.usbserial-A9IRWAKQ"
alias serial="picocom -b 9600 -r -l /dev/tty.usbserial-1430"

# Net lookups shortcuts:
alias ipinfo="curl http://ip-api.com/"
alias macinfo="curl https://api.macvendors.com/"

# Python scripts shortcuts:
alias macvendor="bash ~/nettools/macvendor/macvendor.sh"
alias macadd="bash ~/nettools/macadd/macadd.sh"
alias checknet="bash ~/nettools/checknet/checknet.sh"
alias ipaddinfo="bash ~/nettools/ipaddinfo/ipaddinfo.sh"
alias pingmon="python ~/nettools/pingmon/pingmon.py"alias pingmon="python3 /Users/juaramirez/dev/pingmon/pingmon.py" 

alias curltime="curl -o /dev/null -s -w 'Total: %{time_total}s\n'"
#alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
#alias control='ssh jcramirez@control.netbird.cloud -t "tmux new-session -s work || tmux attach-session -t work"'
alias control="mosh jcramirez@control.netbird.cloud -- sh -c 'tmux attach-session -t ws || tmux new-session -s ws'"
alias control02="mosh jcramirez@control02.netbird.cloud -- sh -c 'tmux attach-session -t ws || tmux new-session -s ws'"

alias work='tmux a -t work'
alias python="python3"
