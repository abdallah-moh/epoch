public class Epoch.PreferencesView : Gtk.Grid {
    private Epoch.CitiesChooser cities_chooser;
    
    public Gtk.Button done_button;
    
    construct {
        margin = 24;
        
        cities_chooser = new Epoch.CitiesChooser ();
        
        attach (cities_chooser, 0, 0);
        
        done_button = new Gtk.Button.with_label (_("Done"));
        done_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        
        attach (done_button, 4, 4);
    }
}
