First things first, thank you to [original repo](https://github.com/jcdickinson/zed-cached/tree/main).


## Future Plans

> I plan to change this to have my own version of Zed soon with C++ based PDF-Viewer and other features that I have on my branches of Zed, which am not sure Zed would have ;D. 

But for now it will be nightly from the upstream Zed.

# Usage

Add cachix to your Nix configuration:

```nix
  nix.settings = {
    substituters = [
      "https://mostlyk.cachix.org"
    ];
    trusted-public-keys = [
      "mostlyk.cachix.org-1:nsaS16kwEs4fRnKYpCpOtIDzjkdOqD7rbgj0/KFku7k="
    ];
  };
```

Then you can use it in flake:

```nix
# flake.nix
{
  inputs.mostlyk-zed.url = "github:mostlykiguess/zed-nix-cache";
  outputs = { self, mostlyk-zed, ... }: {
    mostlyk-zed.packages.x86_64-linux.default
  };
}
```

or run directly:

```bash
nix run github:mostlykiguess/zed-nix-cache
```

## How it works

A GitHub Action runs every 6 hours to check for new stable Zed releases. When a new release is found:

- Creates a branch zed-{version}
- Updates flake.lock to pin to that release
- Builds the package for x86_64-linux
- Pushes the build to Cachix
- Updates the stable branch

The stable branch always points to the latest stable Zed release with pre-built binaries available in Cachix.
