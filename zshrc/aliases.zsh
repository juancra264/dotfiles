# System shortcuts
alias sr='source ~/.zshrc'
alias ls="exa --color=auto"
alias cat="bat --color=auto --plain"
alias grep="grep --color=auto"
alias vim="nvim"
alias commit="PRE_COMMIT_ALLOW_NO_CONFIG=1 git commit -m"
# Remote SSH shortcuts:
alias rpiap="ssh -p 65022 jcramirez@rpi.ap"
alias eveng="ssh root@192.168.186.21"
alias coboe1="ssh jcramirez@10.203.32.62"
alias rancid="ssh batman.adminml.com admin_juaramirez@10.198.26.213"
alias awsvi="ssh batman.adminml.com juaramirez@10.198.36.9"
alias backup="ssh batman.adminml.com ubuntu@10.61.51.21"
alias nac_publisher_backup="batman appadmin@10.121.2.100 -c aes128-cbc"
alias nac_publisher_ppal="batman appadmin@10.61.51.42 -c aes128-cbc"
alias batman="ssh batman.adminml.com"
# GCP shortcuts:
alias gclist="gcloud compute instances list"
alias eve="gcloud compute ssh eveng --project ramirezangel --zone us-central1-a"
alias eve_start="gcloud compute instances start eveng"
alias eve_stop="gcloud compute instances stop eveng"
alias ubuntu01="gcloud compute ssh ubuntu01 --project ramirezangel --zone us-central1-a --ssh-flag '-L 5901:localhost:5901'"
# AWS shortcuts
alias gns3_ssh="ssh -i .ssh/jcramirez.pem ubuntu@54.196.33.149"
alias gns3_stop="aws ec2 stop-instances --instance-ids i-0383133b77d1cea3e"
alias gns3_start="aws ec2 start-instances --instance-ids i-0383133b77d1cea3e"
alias ec2list="aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{Instance:InstanceId,PublicIPAddress:PublicIpAddress}'"
# Serial (picocom) shortcuts
alias pico="picocom -b 9600 -r -l /dev/tty.usbserial-A9IRWAKQ"
alias serial="picocom -b 9600 -r -l /dev/tty.usbserial-1430"
# Python scripts shortcuts:
alias pingmon="python3 /Users/juaramirez/dev/pingmon/pingmon.py" 

alias curltime="curl -o /dev/null -s -w 'Total: %{time_total}s\n'"
#alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
