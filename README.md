# homebrew-belt

Homebrew repository for belt command

```shell
brew tap waltzofpearls/belt
brew install belt
```

**NOTE** If you are running into the following error when you are trying to `brew upgrade belt`:

```shell
Error: belt: undefined method `split' for nil:NilClass
```

Then run the these commands to fix it:

```shell
brew uninstall belt
brew untap waltzofpearls/belt
brew tap waltzofpearls/belt
brew install belt
```
