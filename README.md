# cvefixer

Fix CVEs (update your Linux computer's many little applications).

# Requirements

Ruby! We recommend using [rbenv](https://github.com/rbenv/rbenv).

# Installation

```shell
gem install cvefixer
```

# Usage

```shell
Commands:
  cvefixer all             # update everything
  cvefixer help [COMMAND]  # Describe available commands or one specific command
  cvefixer misc            # update miscellaneous apps
  cvefixer os              # update OS packages
  cvefixer ruby            # update Ruby-related items
  cvefixer rust            # update Rust-related items
  cvefixer version         # what version am I running?
```

# Configuration

You can define hook scripts to be run by `cvefixer all` and `cvefixer hooks`, specified as follows in the JSON config file:

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
