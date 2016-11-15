## macos-jhbuild ##

Temporary repository with the necessary configuration to build GNOME modulesets using jhbuild on macOS.

### Requirements ###
- macOS 10.9 or later
- Xcode

### How to use ###
- `git clone https://github.com/ptomato/macos-jhbuild`
- `cd macos-jhbuild`
- `./setup.sh`
- Edit `~/.jhbuildrc-custom` as desired
- If you intend to make app bundles you must temporarily unlink your Homebrew modules until you're done building: `brew list -1 | while read line; do brew unlink $line; done` (ask `brew doctor` how to get them back)
- `jhbuild bootstrap`
- `jhbuild sysdeps` and make sure nothing looks odd
- `jhbuild list` and make sure nothing looks odd
- `jhbuild build`
