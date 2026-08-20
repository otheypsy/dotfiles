# dotfiles

## Subtree Setup

### Add Remote as Subtree

```
# --- Add subtree repo as upstream for pull --- #
git remote add -f pull-mpv-net-config https://github.com/otheypsy/mpv-net-config.git

# --- Create directory in primary repo as destination for subtree repo --- #
git subtree add --prefix mpv.net pull-mpv-net-config main --squash

# --- Fetch subtree repo changes from upstream --- #
git fetch mpv-net-config main

# --- Update primary repo's local with upstream changes --- #
git subtree pull --prefix {local_directory} {remote_repo} {remote_branch}
git subtree pull --prefix mpv.net pull-mpv-net-config main --squash
```

### Push Changes to Subtree Remote

```
# --- Add substree repo as a remote for push --- #
git remote add push-mpv-net-config https://github.com/otheypsy/mpv-net-config.git

# --- Push changes in primary repo's local to upstream --- #
git subtree push --prefix {local_directory} {remote_repo} {remote_branch}
git subtree push --prefix mpv.net push-mpv-net-config main
```
