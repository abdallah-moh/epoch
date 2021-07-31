/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Your Name <singharajdeep97@gmail.com>
 */

public class Epoch.MainWindow : Hdy.ApplicationWindow {

    private Epoch.PreferencesView preferences_view;
    private Epoch.MainView main_view;

    private GLib.Settings settings;

    public MainWindow (Application app) {
        Object (
            application: app,
            icon_name: "com.github.Suzie97.epoch",
            resizable: false,
            width_request: 500
        );
    }

    construct {
        Hdy.init ();

        set_keep_below (true);
        stick ();

        preferences_view = new Epoch.PreferencesView ();
        main_view = new Epoch.MainView ();

        var content_area = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT,
            vhomogeneous = false
        };
        content_area.add (main_view);
        content_area.add (preferences_view);

        var main_grid = new Gtk.Grid () {
            hexpand = true,
            margin = 0
        };
        main_grid.add (content_area);

        var event_box = new Gtk.EventBox () {
            margin_start = 3,
            margin_end = 3
        };
        event_box.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);
        event_box.add (main_grid);

        var handle = new Hdy.WindowHandle ();
        handle.add (event_box);

        add (handle);

        settings = new GLib.Settings ("com.github.Suzie97.epoch");

        move (settings.get_int ("pos-x"), settings.get_int ("pos-y"));

        delete_event.connect (e => {
            return before_destroy ();
        });

        main_view.close_button.clicked.connect (() => {
            before_destroy ();
            destroy ();
        });

        show_all ();

        event_box.enter_notify_event.connect ((event) => {
            main_view.close_button_revealer.reveal_child = true;
            main_view.preferences_button_revealer.reveal_child = true;
        });

        event_box.leave_notify_event.connect ((event) => {
            main_view.close_button_revealer.reveal_child = false;
            main_view.preferences_button_revealer.reveal_child = false;
        });

        main_view.preferences_button.clicked.connect (() => {
            content_area.visible_child = preferences_view;
            main_view.preferences_button.visible = false;
        });

        preferences_view.workspace_switch.notify["active"].connect (() => {
            desktop_lock ();
        });

        settings.bind ("workspace-stick", preferences_view.workspace_switch, "active", GLib.SettingsBindFlags.DEFAULT);

        preferences_view.done_button.clicked.connect (() => {
            content_area.visible_child = main_view;
            main_view.preferences_button.visible = true;
        });
    }

    private void desktop_lock () {
        if (preferences_view.workspace_switch.active) {
            unstick ();
        } else {
            stick ();
        }
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
