# Useful misc snippets

Linux ubuntu keystore with git:
```
sudo apt-get install libsecret-1-0 libsecret-1-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
git config --global credential.helper    /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
```

Profiling .bashrc:
```bash
PS4='+ $(date "+%s.%N")\011 '
exec 3>&2 2>/tmp/bashstart.$$.log
set -x

# anything in here will get profiled, and the profile will be written to /tmp/bashstart.ID.log

set +x
exec 2>&3 3>&-
```

