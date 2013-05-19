export PATH=/usr/local/share/npm/bin:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:$PATH
export DISPLAY=:0.0
export EDITOR="/usr/local/bin/mate -w"
export MANPAGER="less -X"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

LC_ALL=ru_RU.utf-8

# Check that terminfo exists before changing TERM var to xterm-256color
# Prevents prompt flashing in Mac OS X 10.6 Terminal.app
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
fi

tput sgr 0 0

# Base styles and color palette
# Solarized colors
# https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
BOLD=$(tput bold)
RESET=$(tput sgr0)
SOLAR_YELLOW=$(tput setaf 136)
SOLAR_ORANGE=$(tput setaf 166)
SOLAR_RED=$(tput setaf 124)
SOLAR_MAGENTA=$(tput setaf 125)
SOLAR_VIOLET=$(tput setaf 61)
SOLAR_BLUE=$(tput setaf 33)
SOLAR_CYAN=$(tput setaf 37)
SOLAR_GREEN=$(tput setaf 64)
SOLAR_WHITE=$(tput setaf 254)

style_user="$RESET$SOLAR_ORANGE"
style_host="$RESET$SOLAR_YELLOW"
style_path="$RESET$SOLAR_GREEN"
style_branch="$RESET$SOLAR_CYAN"
style_chars="$RESET$SOLAR_WHITE"

if [[ "$SSH_TTY" ]]; then
    # connected via ssh
    style_host="$BOLD$SOLAR_RED"
elif [[ "$USER" == "root" ]]; then
    # logged in as root
    style_user="$BOLD$SOLAR_RED"
fi

# Git status.
# Adapted from: https://github.com/cowboy/dotfiles/
function prompt_git() {
    local status output flags
    status="$(git status 2>/dev/null)"
    [[ $? != 0 ]] && return;
    output="$(echo "$status" | awk '/# Initial commit/ {print "(init)"}')"
    [[ "$output" ]] || output="$(echo "$status" | awk '/# On branch/ {print $4}')"
    [[ "$output" ]] || output="$(git branch | perl -ne '/^\* (.*)/ && print $1')"
    flags="$(
    echo "$status" | awk 'BEGIN {r=""} \
        /^# Changes to be committed:$/        {r=r "+"}\
        /^# Changes not staged for commit:$/  {r=r "!"}\
        /^# Untracked files:$/                {r=r "?"}\
        END {print r}'
    )"
    if [[ "$flags" ]]; then
        output="$output[$flags]"
    fi
    echo "$style_chars on $style_branch$output"
}

# Build the prompt
PS1="\n" # Newline
PS1+="$style_user\u" # Username
PS1+="$style_chars@" # @
PS1+="$style_host\h" # Host
PS1+="$style_chars: " # :
PS1+="$style_path\w" # Working directory
PS1+="\$(prompt_git)" # Git details
PS1+="\n" # Newline
PS1+="$style_chars\$ $RESET" # $ (and reset color)

alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias cp='cp -iP'
alias df='df -h'
alias dh='du -h -s * | grep -vE '\''[0-9]k[^0-9A-Za-z]'\'''
alias du='du -h'
alias grep='grep -E --color=auto --exclude='\''*~'\'''
alias ll='ls -Fla'
alias ls='ls -Fhas'
alias la="ls -AGFoh"
alias mv='mv -i'
alias x="exit"
alias digany='dig +noall +answer -t any '
alias restart='sudo apachectl restart'
alias whois="whois -h whois-servers.net"
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='brew update; brew upgrade; brew cleanup; npm update -g; gem update --system; gem update; sudo pear update-channels; sudo pear upgrade-all; sudo pecl upgrade-all'
