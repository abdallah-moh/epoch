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

public class Application : Gtk.Application {
    // public GLib.Settings settings = null;
    
    public Application () {
        Object (
            application_id: "com.github.Suzie97.epoch",
            flags: ApplicationFlags.FLAGS_NONE
        );
        
        // settings = new GLib.Settings ("org.gnome.GWeather");
    }
    
    protected override void activate () {
        Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
        
        var app_window = new Epoch.MainWindow (this);
        
        app_window.show ();
        
        add_window (app_window);
        
        var quit_action = new SimpleAction ("quit", null);
        
        add_action (quit_action);
        set_accels_for_action ("app.quit", {"<Control>q"});
        
        quit_action.activate.connect (() => {
            if (app_window != null) {
                app_window.destroy ();
            }
        });
    }
    
    public static int main (string[] args) {
        var app = new Application ();
        return app.run (args);
    }
}