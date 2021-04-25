public class Epoch.CitiesSearch : Gtk.Grid {
	public GWeather.LocationEntry location_entry;
	
	public Gtk.Label city_label;
    private Gtk.Label timezone_label;
	
	construct {
		location_entry = new GWeather.LocationEntry (GWeather.Location.get_world ());
        location_entry.set_activates_default (true);
        location_entry.changed.connect (location_defined);
        
        city_label = new Gtk.Label ("");
        timezone_label = new Gtk.Label ("");
        
        attach (location_entry, 0, 0);
        
        location_entry.show ();
	}
	
	private void location_defined () {
        GWeather.Location? location = null;
        GWeather.Timezone? timezone = null;
        
        if (location_entry.get_text () != "") {
            location = location_entry.get_location ();
        }
        
        if (location != null) {
            timezone = location.get_timezone ();
            
            city_label.set_text (location.get_city_name ());
            
            if (timezone != null) {
                timezone_label.set_text (timezone.get_tzid ());
            } else {
                timezone_label.set_text ("Unknown Time Zone");
            }
        } else {
            city_label.set_text ("");
            timezone_label.set_text ("");
        }
    }
}
