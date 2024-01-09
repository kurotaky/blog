# blog

## Install

```
bundle
bin/rails s
```

### fly.io command

#### deploy
```
flyctl deploy
fly apps open
```
https://fly.io/docs/rails/getting-started/

#### status check
```
flyctl status
```

### rails console

```
fly ssh console --pty -C "/rails/bin/rails console"
```
