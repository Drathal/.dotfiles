export PATH="${MINGWDIR}:${PATH}"
export PATH="${MSYSDIR}/bin:${PATH}"
export PATH="${HOME}/bin:${PATH}"
export PATH="/c/Program Files/Git/bin:${PATH}"
export PATH="/c/Program Files/TortoiseHg:${PATH}"
export PATH="/c/Program Files/Docker Toolbox:${PATH}"
export PATH="/c/Program Files/nodejs:${PATH}"
export PATH="~/AppData/Local/atom/bin:${PATH}"

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

#export HOME="/c/Users/minger"

dip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

dipall() {
  docker ps | tail -n +2 | while read -a a; do name=${a[$((${#a[@]}-1))]}; echo -ne "$name\t"; docker inspect --format="{{.NetworkSettings.IPAddress}}" $name | cut -d \" -f 4; done
}

myip(){
  docker-machine ip default
}

dclean(){
  docker rm $(docker ps -a -q)
  docker rmi $(docker images -q)
}

dlogin(){
  docker login dockerregistry.cgn.cleverbridge.com
}

killnode(){
  kill -9 $(ps aux | grep 'node' | awk '{print $1}')
  # windows: taskkill /F /IM node.exe
}

listnode(){
  ps aux | grep 'node'
}

startdocker(){
    cd /c/Program\ Files/Docker\ Toolbox/
    start.sh
    cd ~/code/
}

__nodeversion(){
    node --version
}

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
source ~/git-prompt.sh

COLOR_GREEN='\033[32m'
COLOR_PURPLE='\033[35m'
COLOR_YELLOW='\033[33m'
COLOR_CYAN='\033[36m'
COLOR_RED='\031[36m'
COLOR_NC='\033[0m'

PS1="\u ${COLOR_GREEN}\w ${COLOR_NC}"
PS1="$PS1"'$(__git_ps1 "${COLOR_YELLOW}[%s]${COLOR_NC} ")'
PS1="$PS1${COLOR_CYAN}"'$(__nodeversion)'"${COLOR_NC}"
PS1="$PS1"'\$ '

echo -e "${COLOR_GREEN} __      __        __                                ________                __   __            __"
echo -e "/  \    /  \ ____ |  |   ____  ____   _____   ____   \______ \____________ _/  |_|  |__ _____  |  |"
echo -e "\   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \   |    |  \_  __ \__   \\\   __\  |  \\\__   \\ |  |"
echo -e " \        /\  ___/|  |_\  \__(  (_) )  Y Y  \  ___/   |    \`   \  | \// __ \|  | |   Y  \/ __ \|  |__"
echo -e "  \__/\  /  \___  >____/\___  >____/|__|_|  /\___  > /_______  /__|  (____  /__| |___|  (____  /____/"
echo -e "       \/       \/          \/            \/     \/          \/           \/          \/     \/      ${COLOR_NC}"
