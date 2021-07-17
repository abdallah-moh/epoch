public class Epoch.PreferencesView : Gtk.Grid {
    private Epoch.CitiesChooser cities_chooser1;
    private Epoch.CitiesChooser cities_chooser2;
    private Epoch.CitiesChooser cities_chooser3;
    private Epoch.CitiesChooser cities_chooser4;

    public Gtk.Button done_button;
    private Gtk.Button add_clock_button;

    public Granite.ModeSwitch stick_switch;

    construct {
        margin = 24;
        hexpand = true;
        vexpand = true;
        halign = Gtk.Align.CENTER;
        valign = Gtk.Align.CENTER;

        cities_chooser1 = new Epoch.CitiesChooser ();
        cities_chooser2 = new Epoch.CitiesChooser ();
        cities_chooser3 = new Epoch.CitiesChooser ();
        cities_chooser4 = new Epoch.CitiesChooser ();

        add_clock_button = new Gtk.Button.from_icon_name ("list-add-symbolic", Gtk.IconSize.MENU);
        add_clock_button.tooltip_text = _("Add Clock");
        add_clock_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

        done_button = new Gtk.Button.with_label (_("Done")) {
            margin_top = 5
        };
        done_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

        stick_switch = new Granite.ModeSwitch.from_icon_name ("view-paged-symbolic", "computer-symbolic") {
            primary_icon_tooltip_text = _("View on all desktops"),
            secondary_icon_tooltip_text = _("View on one desktop"),
            margin_top = 5
        };

        attach (cities_chooser1, 0, 0);
        attach (cities_chooser2, 1, 0);
        attach (cities_chooser3, 2, 0);
        attach (cities_chooser4, 3, 0);
        attach (stick_switch, 0, 1);
        attach (done_button, 3, 1);
    }
}
