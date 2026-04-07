# My personal NixOS config

To apply changes:

```bash
sudo nixos-rebuild switch --flake ~/nixconf#nixos
```

### History of generations

To leave the last 5 versions:
```bash
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
```

Then clean the store:
```bash
sudo nix-collect-garbage -d
```
