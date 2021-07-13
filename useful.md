# Useful misc snippets

Linux ubuntu keystore with git:
```
sudo apt-get install libsecret-1-0 libsecret-1-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
git config --global credential.helper    /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
```

