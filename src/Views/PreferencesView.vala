/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Your Name <singharajdeep97@gmail.com>
 */

public class Epoch.PreferencesView : Gtk.Grid {
    private static GLib.Settings settings;

    public Gtk.Button done_button;
    private Epoch.TimeZonePicker time_zone_picker;

    public Gtk.Switch workspace_switch;

    static construct {
        settings = new Settings ("com.github.Suzie97.epoch");
    }

    construct {
        margin = 24;
        hexpand = true;
        vexpand = true;
        halign = Gtk.Align.CENTER;
        row_spacing = 6;

        var city_label = new Gtk.Label (_("City:")) {
            margin_end = 10,
            halign = Gtk.Align.END
        };

        var time_format = new Granite.Widgets.ModeButton () {
            margin_bottom = 6
        };
        time_format.append_text (_("Dimapur"));
        time_format.append_text (_("Paris"));
        time_format.append_text (_("Tokyo"));
        time_format.append_text (_("New York"));

        var time_zone_label = new Gtk.Label (_("Time Zone:")) {
            margin_end = 10,
            halign = Gtk.Align.END
        };

        time_zone_picker = new Epoch.TimeZonePicker () {
            hexpand = true,
            margin_bottom = 6
        };
        time_zone_picker.get_style_context ().add_class (Gtk.STYLE_CLASS_FRAME);

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

        attach (city_label, 0, 0);
        attach (time_format, 1, 0, 3);
        attach (time_zone_label, 0, 1);
        attach (time_zone_picker, 1, 1, 3);
        attach (workspace_label, 0, 2);
        attach (workspace_switch, 1, 2);
        attach (workspace_help_label, 1, 3);
        attach (done_button, 3, 4);
    }
}
