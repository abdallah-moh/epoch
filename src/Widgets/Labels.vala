/*
* Copyright (c) 2021 Rajdeep Singha (singharajdeep97@gmail.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
*/

public class Epoch.LabelsGrid : Gtk.Grid {
    public Gtk.Label face1_label;
    public Gtk.Label face2_label;
    public Gtk.Label face3_label;
    public Gtk.Label face4_label;

    public Gtk.Label time1_label;

    private GLib.DateTime now;

    private signal void minute_changed ();

    public GClue.Location? geo_location {get; private set; default = null;}
    public GWeather.Location location;
    private GClue.Simple simple;

    construct {
        seek.begin ();

        face1_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 7
        };
        face1_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        update_time ();

        face2_label = new Gtk.Label ("Cairo") {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 7
        };
        face2_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        face3_label = new Gtk.Label ("London") {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 8
        };
        face3_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        face4_label = new Gtk.Label ("Berlin") {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 8
        };
        face4_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
    }

    private uint calculate_time_until_next_minute () {
        if (now == null) {
            return 60 * 1000;
        }

        var seconds_until_next_minute = 60 - (now.to_unix () % 60);

        return (uint)seconds_until_next_minute * 1000;
    }

    public void update_time () {
        now = new GLib.DateTime.now_local ();
        var settings = new GLib.Settings ("org.gnome.desktop.interface");
        var time_format = Granite.DateTime.get_default_time_format (settings.get_enum ("clock-format") == 1, false);

        time1_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER,
            margin_top = 5
        };
        time1_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
        time1_label.tooltip_text = time_format;
        time1_label.xalign = 0;

        time1_label.label = now.format (time_format);

        uint interval = calculate_time_until_next_minute ();

        Timeout.add (interval, () => {
            now = new GLib.DateTime.now_local ();
            time1_label.label = now.format (time_format);

            return true;
        });
    }

    // Get the users location
    public async void seek () {
        try {
            simple = yield new GClue.Simple ("com.github.Suzie97.epoch", GClue.AccuracyLevel.CITY, null);
        } catch (Error e) {
            warning ("Failed to connect to GeoClue2 service: %s", e.message);
            return;
        }

        simple.notify["location"].connect (() => {
            on_location_updated.begin ();
        });

        on_location_updated.begin ();
    }

    public async void on_location_updated () {
        geo_location = simple.get_location ();

        location = location.find_nearest_city (geo_location.latitude, geo_location.longitude);

        if (location != null) {
            face1_label.label = dgettext ("libgweather-locations", location.get_city_name ());
        }
    }
}
