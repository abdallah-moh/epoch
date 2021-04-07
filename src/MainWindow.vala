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

public class Epoch.MainWindow : Gtk.ApplicationWindow {

    private Epoch.PreferencesView preferences_view;
    private Epoch.MainView main_view;
    
    private GLib.Settings settings;
    
    public MainWindow (Application app) {
        Object (
            application: app,
            // deletable: false,
            icon_name: "com.github.Suzie97.epoch",
            resizable: false,
            title: _("Epoch"),
            width_request: 500
        );
    }
    
    construct {
        get_style_context ().add_class ("rounded");
        set_keep_below (true);
        stick ();
        
        var preferences_button = new Gtk.Button.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        preferences_button.valign = Gtk.Align.CENTER;
        
        preferences_view = new Epoch.PreferencesView ();
        main_view = new Epoch.MainView ();
        
        var content_area = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.CROSSFADE,
            vhomogeneous = false
        };
        content_area.add (main_view);
        content_area.add (preferences_view);
        
        var main_grid = new Gtk.Grid () {
            hexpand = true,
            margin = 16
        };
        main_grid.get_style_context ().add_class ("main_grid");
        main_grid.add (content_area);
        
        var headerbar = new Gtk.HeaderBar ();
        
        var headerbar_style_context = headerbar.get_style_context ();
        headerbar_style_context.add_class ("default-decoration");
        headerbar_style_context.add_class (Gtk.STYLE_CLASS_FLAT);
        
        headerbar.pack_end (preferences_button);
        
        set_titlebar (headerbar);
        
        add (main_grid);
        
        settings = new GLib.Settings ("com.github.Suzie97.epoch");
        
        move (settings.get_int ("pos-x"), settings.get_int ("pos-y"));
        
        delete_event.connect (e => {
            return before_destroy ();
        });
        
        show_all ();
        
        preferences_button.clicked.connect (() => {
            content_area.visible_child = preferences_view;
            preferences_button.visible = false;
        });
        
        preferences_view.done_button.clicked.connect (() => {
            content_area.visible_child = main_view;
            preferences_button.visible = true;
        });
    }

    public bool before_destroy () {
        int width, height, x, y;
        
        get_size (out width, out height);
        get_position (out x, out y);
        
        settings.set_int ("pos-x", x);
        settings.set_int ("pos-y", y);
        
        return false;
    }
}