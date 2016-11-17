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
- `cd` to your install directory (whatever you put as `prefix` in `~/.jhbuildrc-custom`)
- `cp root-dbus-broken/Library/LaunchAgents/org.freedesktop.dbus-session.plist ~/Library/LaunchAgents/`
- `rm -rf root-dbus-broken`
- `jhbuild run dbus-uuidgen --ensure=var/lib/dbus/machine-id`
- `jhbuild sysdeps` and make sure nothing looks odd
- `jhbuild list` and make sure nothing looks odd
- `jhbuild build`

### Modules that currently need patches or changes ###
For `meta-gnome-devel-platform`:
- gtk+: https://bugzilla.gnome.org/show_bug.cgi?id=772281

For `meta-gnome-extended-devel-platform`:
- pygobject: https://bugzilla.gnome.org/show_bug.cgi?id=773803
- libpeas: https://bugzilla.gnome.org/show_bug.cgi?id=774175
- libsecret: https://bugzilla.gnome.org/show_bug.cgi?id=734630
- gnome-online-accounts: We are stuck on an older version of WebKit for now; both uses of `webkit_dom_dom_window_webkit_message_handlers_post_message()` in `src/goabackend/goawebextension.c` need to be commented out

Other:
- gcab:
  - https://bugzilla.gnome.org/show_bug.cgi?id=774342
  - https://bugzilla.gnome.org/show_bug.cgi?id=708257
