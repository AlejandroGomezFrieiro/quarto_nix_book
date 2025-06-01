# Quarto Nix book flake

This is a simple [nix flake](https://nixos.wiki/wiki/flakes) to generate a [quarto](https://quarto.org) book. It is inspired by [this repo](https://github.com/b-rodrigues/quarto_book_nix) which builds a quarto book using nix. However, that package uses R, and does not use flakes which is the standard I prefer. 

## Features

- Based on the basic quarto book project.
- Uses [devenv](https://devenv.sh/) to generate a development shell with quarto, a reasonable version of texlive, and some necessary dependencies.
- Configures a python virtual environment, managed by [uv](https://docs.astral.sh/uv/) for ease of use.
    - Note: Since it's using `nix`, there might be incompatibilities with certain packages even when using `uv`. It is still the best option I know so far to use `python` in a simple manner.

## License

MIT License.
