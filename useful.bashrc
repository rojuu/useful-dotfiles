# no duplicates in history
export HISTCONTROL=ignoreboth:erasedups

# better ls
alias ls='ls --color=auto'
alias l='ls -lHh'
alias ll='l -a'

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


# ssh key thingy
sl() {
  eval $(ssh-agent)
  ssh-add "$1"
}

# run build script more easily
build() {
  if [ -f build.sh ]; then
    ./build.sh
  else
    echo "Build script not found"
  fi
}

# Run vim with fugitive straight away
vgit() {
  vim .git/index
}

# connecting with openvpn more easily
opnvpn() {
  sudo openvpn --auth-nocache --config "$1"
}

# Very simple way to run clang format on changed files in git
cfd() {
  git diff --name-only| xargs clang-format -i
}

# sets make to use -j10 by default, not in all cases though
# for example vscode build task might not respect this
export MAKEFLAGS='-j10'

# use either rg or ag with fzf (pick one)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_DEFAULT_COMMAND='ag --print-all-files --hidden --follow -l -g ""'
