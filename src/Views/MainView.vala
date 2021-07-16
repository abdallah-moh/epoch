public class Epoch.MainView : Gtk.Grid {
    public Gtk.Button preferences_button;
    public Gtk.Button close_button;

    public Gtk.Revealer preferences_button_revealer;
    public Gtk.Revealer close_button_revealer;

    construct {
        var labels = new Epoch.LabelsGrid ();

        preferences_button = new Gtk.Button.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR) {
            valign = Gtk.Align.CENTER
        };

        preferences_button_revealer = new Gtk.Revealer () {
            transition_type = Gtk.RevealerTransitionType.CROSSFADE,
            transition_duration = 600
        };
        preferences_button_revealer.add (preferences_button);

        close_button = new Gtk.Button.from_icon_name ("window-close-symbolic", Gtk.IconSize.SMALL_TOOLBAR) {
            valign = Gtk.Align.CENTER
        };

        close_button_revealer = new Gtk.Revealer () {
            transition_type = Gtk.RevealerTransitionType.CROSSFADE,
            transition_duration = 600
        };
        close_button_revealer.add (close_button);

        var preferences_button_grid = new Gtk.Grid () {
            margin_top = 5,
            margin_left = 0
        };
        preferences_button_grid.add (preferences_button_revealer);

        var close_button_grid = new Gtk.Grid () {
            margin_top = 5,
            margin_right = 0
        };
        close_button_grid.add (close_button_revealer);

        var clock_face1 = new ClockFaces ();
        var clock_face2 = new ClockFaces ();
        var clock_face3 = new ClockFaces ();
        var clock_face4 = new ClockFaces ();

        var grid_face1 = new Gtk.Grid ();
        grid_face1.attach (clock_face1, 0, 0);
        grid_face1.attach (labels.face1_label, 0, 1);

        var grid_face2 = new Gtk.Grid ();
        grid_face2.attach (clock_face2, 1, 0);
        grid_face2.attach (labels.face2_label, 1, 1);

        var grid_face3 = new Gtk.Grid ();
        grid_face3.attach (clock_face3, 2, 0);
        grid_face3.attach (labels.face3_label, 2, 1);

        var grid_face4 = new Gtk.Grid ();
        grid_face4.attach (clock_face4, 3, 0);
        grid_face4.attach (labels.face4_label, 3, 1);

        var grid = new Gtk.Grid () {
            column_spacing = 12,
            margin_top = 24,
            margin_bottom = 24
        };
        grid.attach (grid_face1, 0, 1, 1, 2);
        grid.attach (grid_face2, 1, 1, 1, 2);
        grid.attach (grid_face3, 2, 1, 1, 2);
        grid.attach (grid_face4, 3, 1, 1, 2);

        attach (close_button_grid, 0, 0, 1, 1);
        attach (grid, 1, 0, 1, 1);
        attach (preferences_button_grid, 3, 0, 1, 1);
    }
}
