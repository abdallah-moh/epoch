/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Your Name <singharajdeep97@gmail.com>
 */

public class Application : Gtk.Application {

    public Application () {
        Object (
            application_id: "com.github.Suzie97.epoch",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });

        var app_window = new Epoch.MainWindow (this);

        app_window.show ();

        add_window (app_window);

        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {"<Control>q"});

        quit_action.activate.connect (() => {
            get_windows ().foreach ((win) => {
                ((Epoch.MainWindow)win).before_destroy ();
                app_window.destroy ();
            });
        });
    }

    public static int main (string[] args) {
        var app = new Application ();
        return app.run (args);
    }
}
