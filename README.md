# dotfiles

## install
```bash
./mini_install.sh
```

NB that that home-manager and starship are not required but they are recommended.

## Info on selected packages

### nix & home-manager

Need Nix package manager, but not Nix OS

```bash
# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon
# test installation
nix-shell -p nix-info --run "nix-info -m"
# source
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
# when installing home-manager I removed the ~/.profile
# and I had to source ~/.bashrc I've included an example here
```

- search for packages: `nix search nixpkgs starship`
- home-manager plugins: `nix-env -f '<nixpkgs>' -qaP -A vimPlugins`


### starship

- [starship](https://starship.rs/)

```bash
# run command to install and update
curl -sS https://starship.rs/install.sh | sh
# bash: in ~/.bashrc
eval "$(starship init bash)"
# fish: in ~/.config/fish/config.fish
starship init fish | source
```

### copilot in vim (requires node.js)

- requires node.js
- [install](https://nodejs.org/en/download/)
- will append to my .bashrc



