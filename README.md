# cvefixer

Fix CVEs. (Update your Linux computer's many little applications.)

# Requirements

Rust!

# Installation

```shell
cargo install cvefixer
```

# Usage

```shell
Usage: cvefixer [COMMAND]

Commands:
  all      Run all update tasks
  bun      Update Bun
  deno     Update Deno
  flatpak  Update Flatpak packages
  hooks    Run configured hook scripts
  os       Update OS packages
  rust     Update Rust and Cargo packages
  ruby     Update Ruby and Gems
  test     Test command for development
  help     Print this message or the help of the given subcommand(s)
```

# Configuration

You can define hook scripts to be run by `cvefixer all` and `cvefixer hooks`,
specified as follows in the JSON config file:

```json
{
  "hooks": [
    "/home/janie/.local/bin/update_git_repos.sh"
  ]
}
```

cvefixer looks for the config file in the following locations, in random order:

- `$HOME/.config/cvefixer/cvefixer.json`
- `$HOME/.config/cvefixer/config.json`
- `$HOME/.config/cvefixer.json`
- `$HOME/cvefixer.json`
- `$HOME/.cvefixer.json`
