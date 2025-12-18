# nvim-flake 

This is my personal configuration started from [Kickstart-nix.nvim](https://github.com/nix-community/kickstart-nix.nvim), I really liked the design and decided to base my configuration on it, if you are seeing this don't copy from me instead start from scratch, because I deviate a good amount with my own biases.

## Installation

If you would like to install this into your configuration you can do so by adding the input into your system flake, and then adding this to your configuration:

```nix
nixpkgs.overlays = [
    nvim-flake.overlays.default
];

environment.systemPackages = with pkgs; [
    nvim-pkg # The default package added by the overlay
];
```

## Testing 
You run this with:

```console
nix run "github:kossLAN/NvimFlake"
```
