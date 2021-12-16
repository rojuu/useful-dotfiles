# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bash-completion for arch (have to install with pacman first)
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
      . /usr/share/bash-completion/bash_completion

# no duplicates in history
export HISTCONTROL=ignoreboth:erasedups

# ls aliases
alias ls='ls --color=auto'
alias l='ls -lFh'
alias ll='ls -alFh'

# simple PS1 with or without color
PS1='\u@\h:\w\$ '
PS1='\[\033[0m\]\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ '

# git branch info
parse_git_branch() {
  GIT_BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
  if [ "$GIT_BRANCH" != "" ] ; then
    echo "$GIT_BRANCH"
  else
    echo ""
  fi
}
export PS1+="\[\033[37m\]\$(parse_git_branch)\[\033[00m\]"

# Alternative PS1 look (colored and multiline with git info)
# NOTE: Needs parse_git_branch function
PS1='\[\033[0m\]\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]'
export PS1+=" \[\033[37m\]\$(parse_git_branch)\[\033[00m\]"
export PS1+="\n> "


### ARCHIVE EXTRACTION
# usage: ex <file>
ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# run build script more easily
build() {
  if [ -f build.sh ]; then
    ./build.sh "$@"
  else
    echo "Build script not found"
  fi
}

run() {
  if [ -f run.sh ]; then
    ./run.sh "$@"
  else
    echo "Run script not found"
  fi
}

# Very simple way to run clang format on changed files in git
cfd() {
  CF_FILES__=$(git diff --name-only)
  CF_FILES__+=" "
  CF_FILES__+=$(git diff --cached --name-only)
  if [ "$CF_FILES__" == " " ]; then
    echo "No changed files"
  else
    for cf in $CF_FILES__; do
      case $cf in
        *.cpp)   clang-format -i --verbose $cf ;;
        *.h)     clang-format -i --verbose $cf ;;
        *.hpp)   clang-format -i --verbose $cf ;;
        *.inl)   clang-format -i --verbose $cf ;;
        *)       echo "Ignoring formatting for file '$cf'" ;;
      esac
    done
  fi
}

# Very simple way to run zig fmt on changed files in git
zfd() {
  ZF_FILES__=$(git diff --name-only)
  ZF_FILES__+=" "
  ZF_FILES__+=$(git diff --cached --name-only)
  if [ "$CF_FILES__" == " " ]; then
    echo "No changed files"
  else
    for zf in $ZF_FILES__; do
      case $zf in
        *.zig)   zig $zf ;;
        *)       echo "Ignoring formatting for file '$zf'" ;;
      esac
    done
  fi
}

# sets make to use -j10 by default, not in all cases though
# for example vscode build task might not respect this
export MAKEFLAGS='-j10'

# use either rg or ag with fzf (pick one)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_DEFAULT_COMMAND='ag --print-all-files --hidden --follow -l -g ""'

