public class Epoch.PreferencesView : Gtk.Grid {
    private Epoch.CitiesChooser cities_chooser;
    
    public Gtk.Button done_button;
    
    public Granite.ModeSwitch stick_switch;
    
    construct {
        margin = 24;
        
        cities_chooser = new Epoch.CitiesChooser ();
        
        done_button = new Gtk.Button.with_label (_("Done"));
        done_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        
        stick_switch = new Granite.ModeSwitch.from_icon_name ("view-paged-symbolic", "computer-symbolic");
        stick_switch.primary_icon_tooltip_text = _("View on all desktops");
        stick_switch.secondary_icon_tooltip_text = _("View on one desktop");
        
        attach (done_button, 4, 4);
        attach (cities_chooser, 0, 0);
        attach (stick_switch, 1, 0);
    }
}
