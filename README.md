First things first, thank you to [original repo](https://github.com/jcdickinson/zed-cached/tree/main).


## What this builds

Zed `main` with my LaTeX math rendering for the Markdown preview merged in, from [zed-industries/zed#54668](https://github.com/zed-industries/zed/pull/54668). Once that PR is merged upstream, this goes back to plain Zed `main`.

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

A GitHub Action runs every Tuesday, and can also be started by hand:

- Merges the `latex-math` branch onto the latest Zed `main` and pushes the result to the `latex-math-on-main` branch of my fork. If the merge conflicts, the branch keeps the last good merge.
- Updates `flake.lock` to that branch
- Builds the package for x86_64-linux
- Pushes the build to Cachix
- Commits the new `flake.lock`
