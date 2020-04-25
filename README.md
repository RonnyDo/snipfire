# Snipfire Screenshot Tool

Grab screenhshots with the catch of an eye.

* No bullshit capture mode
* Shortcodes! Shortcodes everywhere!!
* Share online
* Quick editing

![Screenshot Tool Screenshot](data/screenshot.png?raw=true)

## Building, Testing, and Installation

You'll need the following dependencies:

* meson >= 0.43.0
* libcanberra-dev
* libgdk-pixbuf2.0-dev
* libgranite-dev >= 5.4.0
* valac

Run `meson` to configure the build environment and then `ninja` to build and run automated tests

    meson build --prefix=/usr
    cd build
    ninja

To install, use `ninja install`, then execute with `io.elementary.screenshot-tool`

    sudo ninja install
    io.elementary.screenshot-tool
