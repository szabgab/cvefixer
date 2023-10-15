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

# Publishing this Gem to rubygems.org

```
gem build
mv cvefixer*gem tmp
cd tmp
gem push cvefixer*gem
```
