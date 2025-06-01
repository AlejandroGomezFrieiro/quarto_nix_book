# Quarto Nix book flake

This is a simple [nix flake](https://nixos.wiki/wiki/flakes) to generate a [quarto](https://quarto.org) book. It is inspired by [this repo](https://github.com/b-rodrigues/quarto_book_nix) which builds a quarto book using nix. However, that package uses R, and does not use flakes which is the standard I prefer. 

## Features

- Based on the basic quarto book project.
- Uses [devenv](https://devenv.sh/) to generate a development shell with quarto, a reasonable version of texlive, and some necessary dependencies.
- Configures a python virtual environment, managed by [uv](https://docs.astral.sh/uv/) for ease of use.
    - Note: Since it's using `nix`, there might be incompatibilities with certain packages even when using `uv`. It is still the best option I know so far to use `python` in a simple manner.
- Build PDF file and HTML on CI/CD pipeline.
    - Automatic publishing is not automatically set.
    - Artifacts are collected! Check `.github/workflows/build.yml`.

## How to use

### Setting up nix flakes
This github repository is based on a nix flake, so it is assumed that nix is installed in your system. If not, then I would recommend installing [lix](https://lix.systems/install/), a community-developed fork of nix. Alternatively, you might want to try using the main nix [installer](https://nix.dev/install-nix.html). Another popular installer is the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer). 

Nix flakes are still considered an experimental feature, but have been widely accepted in the community. Follow [these instructions](https://nixos.wiki/wiki/Flakes) if your installation does not enable flakes by default.

### Initialize environment

First clone and enter the repository

```bash
git clone git@github.com:AlejandroGomezFrieiro/quarto_nix_book.git; cd quarto_nix_book
```

If you have `direnv` installed, then just allow it with `direnv allow`. Otherwise, you need to run

```bash
nix develop --no-pure-eval
```

Then use quarto and python as usual.

## Improvements

I would like to make this repository more general by adding several templates for articles, websites etc. As well as using `uv2nix` instead of `devenv` to setup the python environment. But the current way it is setup is sufficient for myself.

## License

MIT License.
