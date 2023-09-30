# playdate experimenting

## initial setup

```console
cargo search
cargo install --git="https://github.com/boozook/playdate.git" cargo-playdate --bin=cargo-playdate
```

TODO: do this in the flake

## setting up a new project

```console
mkdir new-project && cd $_
cargo playdate init --lib --full-metadata --deps="playdate"
cargo playdate run
```
