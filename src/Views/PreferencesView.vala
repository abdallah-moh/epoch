public class Epoch.PreferencesView : Gtk.Grid {
    private Epoch.CitiesChooser cities_chooser;

    public Gtk.Button done_button;
    private Gtk.Button add_clock_button;

    public Granite.ModeSwitch stick_switch;
    public Granite.ModeSwitch lock_switch;

    construct {
        margin = 24;

        var cities_chooser_grid = new Gtk.Grid ();
        //cities_chooser_grid.hexpand = true;
        cities_chooser = new Epoch.CitiesChooser ();

        add_clock_button = new Gtk.Button.from_icon_name ("list-add-symbolic", Gtk.IconSize.MENU);
        add_clock_button.tooltip_text = _("Add Clock");
        add_clock_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

        cities_chooser_grid.attach (cities_chooser, 0, 0);
        cities_chooser_grid.attach (add_clock_button, 0, 1);

        done_button = new Gtk.Button.with_label (_("Done"));
        done_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

        stick_switch = new Granite.ModeSwitch.from_icon_name ("view-paged-symbolic", "computer-symbolic") {
            primary_icon_tooltip_text = _("View on all desktops"),
            secondary_icon_tooltip_text = _("View on one desktop")
        };

        lock_switch = new Granite.ModeSwitch.from_icon_name ("changes-allow-symbolic", "changes-prevent-symbolic") {
            primary_icon_tooltip_text = _("Window drag allowed"),
            secondary_icon_tooltip_text = _("Window position locked")
        };

        attach (done_button, 2, 2);
        attach (cities_chooser_grid, 0, 0);
        attach (stick_switch, 0, 1);
        attach (lock_switch, 1, 1);
    }
}
