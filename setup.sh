#!/bin/sh
#
# Script that sets up jhbuild, and the jhbuildrc files and moduleset
# files as symlinks from the git repository.
#
# Copyright 2007, 2008 Imendio AB
# Copyright 2016 Philip Chimento
#

SOURCE=..

do_exit()
{
    echo $1
    exit 1
}

if test x`which git` == x; then
    do_exit "Git isn't available, please install it and try again."
fi

if test ! -d $SOURCE; then
    do_exit "The directory $SOURCE does not exist, please create it and try again."
fi

echo "Checking out jhbuild from git..."
if ! test -d $SOURCE/jhbuild; then
    (cd $SOURCE ; git clone git://git.gnome.org/jhbuild )
else
    (cd $SOURCE/jhbuild ; git pull >/dev/null)
fi

echo "Installing jhbuild..."
(cd $SOURCE/jhbuild ; ./autogen.sh >/dev/null && make >/dev/null && make install >/dev/null)

echo "Installing jhbuild configuration..."
mkdir -p $HOME/.config
ln -sfh `pwd`/jhbuildrc $HOME/.config/jhbuildrc
if [ ! -f $HOME/.jhbuildrc-custom ]; then
    cp jhbuildrc-custom-example $HOME/.jhbuildrc-custom
fi

echo "Setting up extra jhbuild files..."
for mod in modulesets/*.modules patches/*.patch; do
    ln -sfh `pwd`/$mod $SOURCE/jhbuild/$mod
done

echo "Done."
