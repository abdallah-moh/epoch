<p align="center">
  <img src="data/128.svg" alt="Icon" />
</p>
<h1 align="center">Epoch</h1>
<h2 align="center">Keep Track of Time in different cities across the World</h2>

Easily see the time of different cities across the world, choose the cities whose time you want to keep track of and pin the widget on multiple workspaces or just a single workspace.

## Made for [elementary OS](https://elementary.io)

Epoch is designed and developed on and for [elementary OS](https://elementary.io). It will be available on AppCenter in the near future. Purchasing through AppCenter directly supports me and elementary. Get it on AppCenter for the best experience.

## Developing and Building

If you want to hack on and build Epoch yourself, you'll need the following dependencies:

* `libgranite-dev`
* `libgtk-3-dev`
* `libhandy-1-dev`
* `cairo`
* `libgeoclue-2-dev`
* `libgweather-3-dev`
* `meson`
* `valac`

Run `meson build` to configure the build environment, use `ninja install` to install the app and then execute with `./com.github.Suzie97.epoch`

    meson build --prefix=/usr
    cd build
    sudo ninja install
    ./com.github.Suzie97.epoch
