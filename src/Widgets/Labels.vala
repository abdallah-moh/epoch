/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Your Name <singharajdeep97@gmail.com>
 */

public class Epoch.LabelsGrid : Gtk.Grid {
    public Gtk.Label face1_label;
    public Gtk.Label face2_label;
    public Gtk.Label face3_label;
    public Gtk.Label face4_label;

    public Gtk.Label time1_label;

    public Gtk.Label day1_label;

    private GLib.DateTime now;

    public GClue.Location? geo_location {get; private set; default = null;}
    public GWeather.Location location;
    private GClue.Simple simple;

    construct {
        seek.begin ();

        face1_label = new Gtk.Label ("Dimapur") {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 7
        };
        face1_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

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

        update_day_time ();
    }

    private uint calculate_time_until_next_minute () {
        if (now == null) {
            return 60 * 1000;
        }

        var seconds_until_next_minute = 60 - (now.to_unix () % 60);

        return (uint)seconds_until_next_minute * 1000;
    }

    public void update_day_time () {
        now = new GLib.DateTime.now_local ();
        var settings = new GLib.Settings ("org.gnome.desktop.interface");
        var time_format = Granite.DateTime.get_default_time_format (settings.get_enum ("clock-format") == 1, false);
        var day_format = Granite.DateTime.get_default_date_format (true, false, false);

        time1_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        time1_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
        time1_label.xalign = 0;

        time1_label.label = now.format (time_format);

        day1_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        day1_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
        day1_label.xalign = 0;

        string weekday = now.format (day_format);

        if (weekday == "Sun") {
            day1_label.label = "Sunday";
        } if (weekday == "Mon") {
            day1_label.label = "Monday";
        } if (weekday == "Tue") {
            day1_label.label = "Tuesday";
        } if (weekday == "Wed") {
            day1_label.label = "Wednesday";
        } if (weekday == "Thu") {
            day1_label.label = "Thursday";
        } if (weekday == "Fri") {
            day1_label.label = "Friday";
        } if (weekday == "Sat") {
            day1_label.label = "Saturday";
        }

        // day1_label.label = now.format (day_format);

        uint interval = calculate_time_until_next_minute ();

        Timeout.add (interval, () => {
            now = new GLib.DateTime.now_local ();
            time1_label.label = now.format (time_format);

            string weekday1 = now.format (day_format);

            if (weekday1 == "Sun") {
                day1_label.label = "Sunday";
            } if (weekday1 == "Mon") {
                day1_label.label = "Monday";
            } if (weekday1 == "Tue") {
                day1_label.label = "Tuesday";
            } if (weekday1 == "Wed") {
                day1_label.label = "Wednesday";
            } if (weekday1 == "Thu") {
                day1_label.label = "Thursday";
            } if (weekday1 == "Fri") {
                day1_label.label = "Friday";
            } if (weekday1 == "Sat") {
                day1_label.label = "Saturday";
            }

            // day1_label.label = now.format (day_format);

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
