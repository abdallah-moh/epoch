/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Your Name <singharajdeep97@gmail.com>
 */

public class Epoch.PreferencesView : Gtk.Grid {
    private static GLib.Settings settings;

    public Gtk.Button done_button;
    private Epoch.TimeZonePicker time_zone_picker;

    public Gtk.Switch workspace_switch;

    public string timezone1;
    public string timezone2;
    public string timezone3;
    public string timezone4;

    public Granite.Widgets.ModeButton timezone_chooser;

    static construct {
        settings = new Settings ("com.github.Suzie97.epoch");
    }

    construct {
        margin = 24;
        hexpand = true;
        vexpand = true;
        halign = Gtk.Align.CENTER;
        row_spacing = 6;

        timezone1 = "Kolkata";
        timezone2 = "Cairo";
        timezone3 = "London";
        timezone4 = "Berlin";

        time_zone_picker = new Epoch.TimeZonePicker () {
            hexpand = true,
            margin_bottom = 6
        };
        time_zone_picker.get_style_context ().add_class (Gtk.STYLE_CLASS_FRAME);

        var clock_label = new Gtk.Label (_("Clock:")) {
            margin_end = 10,
            halign = Gtk.Align.END
        };

        timezone_chooser = new Granite.Widgets.ModeButton () {
            margin_bottom = 6
        };
        timezone_chooser.append_text (timezone1);
        timezone_chooser.append_text (timezone2);
        timezone_chooser.append_text (timezone3);
        timezone_chooser.append_text (timezone4);

        // if (timezone_chooser.selected == 0) {
        //     time_zone_picker.request_timezone_change.connect (() => {
        //         timezone1 = time_zone_picker.current_tz;
        //     });
        // }

        var time_zone_label = new Gtk.Label (_("Time zone:")) {
            margin_end = 10,
            halign = Gtk.Align.END
        };

        var workspace_label = new Gtk.Label (_("Show on one workspace:")) {
            margin_end = 10,
            halign = Gtk.Align.END
        };

        workspace_switch = new Gtk.Switch () {
            halign = Gtk.Align.START,
            valign = Gtk.Align.CENTER
        };

        var workspace_help_label = new Gtk.Label ("The app will only be visible on one workspace") {
            wrap = true,
            xalign = 0
        };
        workspace_help_label.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);

        done_button = new Gtk.Button.with_label (_("Done")) {
            margin_top = 5
        };
        done_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

        attach (clock_label, 0, 0);
        attach (timezone_chooser, 1, 0, 3);
        attach (time_zone_label, 0, 1);
        attach (time_zone_picker, 1, 1, 3);
        attach (workspace_label, 0, 2);
        attach (workspace_switch, 1, 2);
        attach (workspace_help_label, 1, 3);
        attach (done_button, 2, 4);
    }
}
