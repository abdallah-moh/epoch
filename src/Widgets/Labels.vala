/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Your Name <singharajdeep97@gmail.com>
 */

// [DBus (name = "org.freedesktop.login1.Manager")]
// interface Manager : Object {
//     public signal void prepare_for_sleep (bool sleeping);
// }

public class Epoch.LabelsGrid : Gtk.Grid {
    public Gtk.Label face1_label;
    public Gtk.Label face2_label;
    public Gtk.Label face3_label;
    public Gtk.Label face4_label;

    public Gtk.Label time1_label;
    public Gtk.Label time2_label;
    public Gtk.Label time3_label;
    public Gtk.Label time4_label;

    public Gtk.Label day1_label;
    public Gtk.Label day2_label;
    public Gtk.Label day3_label;
    public Gtk.Label day4_label;

    private GLib.DateTime now1;

    private Epoch.TimeZonePicker time_zone_picker;

    // public GClue.Location? geo_location {get; private set; default = null;}
    // public GWeather.Location location;
    // private GClue.Simple simple;

    construct {
        // seek.begin ();
        time_zone_picker = new Epoch.TimeZonePicker ();

        var preferences_view = new Epoch.PreferencesView ();

        face1_label = new Gtk.Label (preferences_view.timezone1) {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 7
        };
        face1_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        time1_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        time1_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
        time1_label.xalign = 0;

        day1_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        day1_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
        day1_label.xalign = 0;

        face2_label = new Gtk.Label (preferences_view.timezone2) {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 7
        };
        face2_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        time2_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        time2_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
        time2_label.xalign = 0;

        day2_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        day2_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
        day2_label.xalign = 0;

        face3_label = new Gtk.Label (preferences_view.timezone3) {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 8
        };
        face3_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        time3_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        time3_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
        time3_label.xalign = 0;

        day3_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        day3_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
        day3_label.xalign = 0;

        face4_label = new Gtk.Label (preferences_view.timezone4) {
            halign = Gtk.Align.CENTER,
            hexpand = true,
            margin_top = 6,
            ellipsize = END,
            max_width_chars = 8
        };
        face4_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        time4_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        time4_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
        time4_label.xalign = 0;

        day4_label = new Gtk.Label ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };
        day4_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
        day4_label.xalign = 0;

        // TODO: Make the suspend mechanism work
        // manager = Bus.get_proxy_sync (BusType.SYSTEM, "org.freedesktop.login1", "/org/freedesktop/login1");
        // manager.prepare_for_sleep.connect ((sleeping) => {
        //     if (sleeping) {
        //         update_day_time ();
        //     }
        // });

        // var clock_settings = new GLib.Settings ("com.github.Suzie97.epoch");
        // clock_settings.bind ("clock-show-seconds", this, "clock-show-seconds", SettingsBindFlags.DEFAULT);

        update_day_time ();

        // var clock_settings = new GLib.Settings ("org.gnome.desktop.interface");
        //     clock_settings.changed["clock-format"].connect (() => {
        //         is_12h = ("12h" in clock_settings.get_string ("clock-format"));
        //     });

        // is_12h = ("12h" in clock_settings.get_string ("clock-format"));
    }

    private uint calculate_time_until_next_minute () {
        if (now1 == null) {
            return 60 * 1000;
        }

        var seconds_until_next_minute = 60 - (now1.to_unix () % 60);

        return (uint)seconds_until_next_minute * 1000;
    }

    public void update_day_time () {
        now1 = new GLib.DateTime.now_local ();
        var settings = new GLib.Settings ("org.gnome.desktop.interface");
        var time_format = Granite.DateTime.get_default_time_format (settings.get_enum ("clock-format") == 1, false);
        var day_format = Granite.DateTime.get_default_date_format (true, false, false);

        string current_time1 = now1.format (time_format);

        time1_label.label = current_time1;

        string weekday = now1.format (day_format);

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

        // day1_label.label = now1.format (day_format);

        uint interval = calculate_time_until_next_minute ();

        // uint interval;

        // if (clock_show_seconds) {
        //     interval = 500;
        // } else {
        //     interval = calculate_time_until_next_minute ();
        // }

        Timeout.add (interval, () => {
            now1 = new GLib.DateTime.now_local ();
            string current_time2 = now1.format (time_format);
            time1_label.label = current_time2;

            string weekday1 = now1.format (day_format);

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

            uint interval1 = calculate_time_until_next_minute ();

            // uint interval1;

            // if (clock_show_seconds) {
            //     interval1 = 500;
            // } else {
            //     interval1 = calculate_time_until_next_minute ();
            // }

            Timeout.add (interval1, () => {
                now1 = new GLib.DateTime.now_local ();
                string current_time3 = now1.format (time_format);
                time1_label.label = current_time3;

                string weekday2 = now1.format (day_format);

                if (weekday2 == "Sun") {
                    day1_label.label = "Sunday";
                } if (weekday2 == "Mon") {
                    day1_label.label = "Monday";
                } if (weekday2 == "Tue") {
                    day1_label.label = "Tuesday";
                } if (weekday2 == "Wed") {
                    day1_label.label = "Wednesday";
                } if (weekday2 == "Thu") {
                    day1_label.label = "Thursday";
                } if (weekday2 == "Fri") {
                    day1_label.label = "Friday";
                } if (weekday2 == "Sat") {
                    day1_label.label = "Saturday";
                }

                return true;
            });

            // day1_label.label = now1.format (day_format);

            return false;
        });
    }

    // // Get the users location
    // public async void seek () {
    //     try {
    //         simple = yield new GClue.Simple ("com.github.Suzie97.epoch", GClue.AccuracyLevel.CITY, null);
    //     } catch (Error e) {
    //         warning ("Failed to connect to GeoClue2 service: %s", e.message);
    //         return;
    //     }

    //     simple.notify["location"].connect (() => {
    //         on_location_updated.begin ();
    //     });

    //     on_location_updated.begin ();
    // }

    // public async void on_location_updated () {
    //     geo_location = simple.get_location ();

    //     location = location.find_nearest_city (geo_location.latitude, geo_location.longitude);

    //     if (location != null) {
    //         face1_label.label = dgettext ("libgweather-locations", location.get_city_name ());
    //     }
    // }
}
