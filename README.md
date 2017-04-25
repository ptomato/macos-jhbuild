## macos-jhbuild ##

Temporary repository with the necessary configuration to build GNOME modulesets using jhbuild on macOS.

### Requirements ###
- macOS 10.9 or later
- Xcode

### How to use ###
- Make sure command line tools are installed (`xcode-select --install`)
- `git clone https://github.com/ptomato/macos-jhbuild`
- `cd macos-jhbuild`
- `./setup.sh`
- Make sure `~/.local/bin` is in your `PATH`
- Edit `~/.jhbuildrc-custom` as desired
- If you intend to make app bundles you must temporarily unlink your Homebrew modules until you're done building: `brew list -1 | while read line; do brew unlink $line; done` (ask `brew doctor` how to get them back)
- `jhbuild bootstrap`
- `cd` to your install directory (whatever you put as `prefix` in `~/.jhbuildrc-custom`)
- `cp _jhbuild/root-dbus-broken/Library/LaunchAgents/org.freedesktop.dbus-session.plist ~/Library/LaunchAgents/`
- `rm -r _jhbuild/root-dbus-broken`
- `jhbuild run dbus-uuidgen --ensure=var/lib/dbus/machine-id`
- `jhbuild sysdeps` and make sure nothing looks odd
- `jhbuild list` and make sure nothing looks odd
- `jhbuild build`

### Modules that currently need patches or changes ###
For `meta-gnome-extended-devel-platform`:
- libpeas: https://bugzilla.gnome.org/show_bug.cgi?id=774175
- libsecret: https://bugzilla.gnome.org/show_bug.cgi?id=734630
- gnome-online-accounts: We are stuck on an older version of WebKit for now; both uses of `webkit_dom_dom_window_webkit_message_handlers_post_message()` in `src/goabackend/goawebextension.c` need to be commented out

### Troubleshooting ###
- `python2: realpath couldn't resolve "/usr/bin/python2"` error
  - `rm ~/.local/bin/python2`
  - Edit `~/.local/bin/python2` as in [this Stack Exchange answer](https://unix.stackexchange.com/a/126567)
  - `chmod +x ~/.local/bin/python2`
