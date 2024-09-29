NVM is quite slow to load up (at least on my machine with WSL2). To lazy load it instead, comment out the normal nvm stuff from `.bashrc` and add the two following files to somewhere in the `PATH`

e.g. add this to .bashrc
```bash
export PATH="$PATH:$HOME/bin"
```

Then in `$HOME/bin/node` add:
```bash
#!/usr/bin/env bash

unset -f node
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

node $@
```

And in $HOME/bin/nvm add:
```bash
#!/usr/bin/env bash

unset -f nvm
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

nvm $@
```

And run `chmod +x "$HOME/bin/node` and `chmod +x "$HOME/bin/nvm`
