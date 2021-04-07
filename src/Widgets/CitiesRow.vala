public class Epoch.CitiesRow : Gtk.Grid {
    
    construct {
        column_spacing = 6;
        
        var city_name_label = new Gtk.Label ("");
        city_name_label.xalign = 0;
        city_name_label.hexpand = true;
        city_name_label.ellipsize = Pango.EllipsizeMode.END;
        
        add (city_name_label);
        
        bind_property ("label", city_name_label, "label");
    }
}
