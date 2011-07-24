export PATH=/Users/simonenko/Solutions/ZendFramework/latest/bin:/usr/local/bin:/usr/local/sbin:$PATH
export DISPLAY=:0.0
export EDITOR=/usr/bin/pico
export ZF_PATH=/Users/simonenko/Solutions/ZendFramework/latest/library
export SVN_EDITOR='mate -w'
export NODE_PATH=/usr/local/lib/node:$NODE_PATH

LC_ALL=ru_RU.utf-8

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\h:\w\$(parse_git_branch)>"
PS2='\h:\w:>'

alias ..='cd ..'
alias cp='cp -iP'
alias df='df -h'
alias dh='du -h -s * | grep -vE '\''[0-9]k[^0-9A-Za-z]'\'''
alias du='du -h'
alias grep='grep -E --color=auto --exclude='\''*~'\'''
alias ll='ls -Fla'
alias ls='ls -Fhas'
alias mv='mv -i'
alias vi='vim -b'
alias digany='dig +noall +answer -t any '
alias restart="sudo apachectl restart"
alias x="exit"
alias zf=zf.sh
alias aempty='find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.placeholder \;'
alias ojpg='jpegoptim --strip-all'
alias opng='optipng'
alias myender='ender -b qwery,bean,bonzo,klass,reqwest,underscore'