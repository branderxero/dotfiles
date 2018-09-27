#  ██                        ██
# ░██                       ░██
# ░██       ██████    ██████░██      ██████  █████
# ░██████  ░░░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
# ░██░░░██  ███████ ░░█████ ░██░░░██ ░██ ░ ░██  ░░
# ░██  ░██ ██░░░░██  ░░░░░██░██  ░██ ░██   ░██   ██
# ░██████ ░░████████ ██████ ░██  ░██░███   ░░█████
# ░░░░░    ░░░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
#
#▓▒░ only interactive shells
[ -z "$PS1" ] && return

#▓▒░ env vars
export EDITOR=nvim
export VISUAL=nvim
export TERM=screen-256color

#█▓▒░ aliases
alias xyzzy="echo nothing happens"
alias ls="ls -hF --color=auto"
alias ll="ls -lahF --color=auto"
alias lsl="ls -lhF --color=auto"
alias "cd.."="cd ../"
alias up="cd ../"
alias rmrf="rm -rf"
alias psef="ps -ef"
alias mkdir="mkdir -p"
alias grep="grep -i"
alias cp="cp -r"
alias scp="scp -r"
alias xsel="xsel -b"
alias fuck='sudo $(fc -ln -1)'
alias e="$EDITOR"
alias se="sudo $EDITOR"
alias v="nvim"
alias vim="nvim"
alias vimdiff="nvim -d -u ~/.vimrc"
alias emacs="nvim"
alias g="git"
alias ga="git add"
alias gc="git commit -m"
alias gs="git status"
alias gd="git diff"
alias gf="git fetch"
alias gm="git merge"
alias gr="git rebase"
alias gp="git push"
alias gu="git unstage"
alias gg="git graph"
alias gco="git checkout"
alias gcs="git commit -S -m"
alias ag="ag --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
alias ZZ="exit"
alias disks='echo "┏━━━━━ m o u n t . p o i n t s"; echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ━ ━ "; lsblk -a; echo ""; echo "┏━━━━━ d i s k . u s a g e"; echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ━ ━ "; df -h;'

#█▓▒░ colorize man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

#█▓▒░ prompt
ICO_DIRTY="*"
ICO_AHEAD="↑"
ICO_BEHIND="↓"
ICO_DIVERGED="↕"
COLOR_ROOT=$(tput setaf 1)
COLOR_USER=$(tput setaf 6)
COLOR_NORMAL=$(tput sgr0)

#█▓▒░ colors for permissions
if [[ "$EUID" -ne "0" ]]
then  # if user is not root
	USER_LEVEL="${COLOR_USER}"
else # root!
	USER_LEVEL="${COLOR_ROOT}"
fi

#█▓▒░ git status
GIT_PROMPT() {
	test=$(git rev-parse --is-inside-work-tree 2> /dev/null)
	if [ ! "$test" ]; then
		return
	fi
	ref=$(git name-rev --name-only HEAD | sed 's!remotes/!!;s!undefined!merging!' 2> /dev/null)
	dirty="" && [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && dirty=$ICO_DIRTY
	stat=$(git status | sed -n 2p)
	case "$stat" in
		*ahead*)
			stat=$ICO_AHEAD
		;;
		*behind*)
			stat=$ICO_BEHIND
		;;
		*diverged*)
			stat=$ICO_DIVERGED
		;;
		*)
			stat=""
		;;
	esac
	echo "${USER_LEVEL}━[${COLOR_NORMAL}"${ref}${dirty}${stat}"${USER_LEVEL}]"
}
export PS1='${USER_LEVEL}[${COLOR_NORMAL}\h${USER_LEVEL}]━${USER_LEVEL}[${COLOR_NORMAL}\w${USER_LEVEL}]$(GIT_PROMPT)━━ ━ \e[0m'
