```
Host *
    identityfile ~/.ssh/id_rsa
    protocol 2
    compression yes
    controlpath ~/.ssh/control/%r@%h:%p
    tcpkeepalive yes
    serveralivecountmax 10
    serveraliveinterval 20
    controlmaster auto
    controlpersist 1800
# Always use SSH2

# Use a shared channel for all sessions to the same host,
# instead of always opening a new one. This leads to much
# quicker connection times.



Host github.com
    identityfile /Users/steve/.ssh/github
    loglevel ERROR
    controlmaster auto
    controlpersist 120
```
