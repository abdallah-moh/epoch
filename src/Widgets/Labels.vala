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

public class Epoch.LabelsGrid : Gtk.Grid {
    public Gtk.Label face1_label;
    public Gtk.Label face2_label;
    public Gtk.Label face3_label;
    public Gtk.Label face4_label;
    
    public GClue.Location? geo_location {get; private set; default = null;}
    public GWeather.Location location;
    private GClue.Simple simple;
    
    construct {
        seek.begin ();
        
        face1_label = new Gtk.Label ("");
        face1_label.halign = Gtk.Align.CENTER;
        face1_label.hexpand = true;
        face1_label.margin_top = 6;
        face1_label.set_ellipsize (END);
        face1_label.set_max_width_chars (12);
        
        face2_label = new Gtk.Label ("Paris");
        face2_label.set_markup ("<span font_desc='Inter 14'><b>Paris</b></span>");
        face2_label.halign = Gtk.Align.CENTER;
        face2_label.hexpand = true;
        face2_label.margin_top = 6;
        face2_label.set_ellipsize (END);
        face2_label.set_max_width_chars (12);
        
        face3_label = new Gtk.Label ("London");
        face3_label.set_markup ("<span font_desc='Inter 14'><b>Tokyo</b></span>");
        face3_label.halign = Gtk.Align.CENTER;
        face3_label.hexpand = true;
        face3_label.margin_top = 6;
        face3_label.set_ellipsize (END);
        face3_label.set_max_width_chars (12);
        
        face4_label = new Gtk.Label ("New York");
        face4_label.set_markup ("<span font_desc='Inter 14'><b>New York</b></span>");
        face4_label.halign = Gtk.Align.CENTER;
        face4_label.hexpand = true;
        face4_label.margin_top = 6;
        face4_label.set_ellipsize (END);
        face4_label.set_max_width_chars (12);
        }
        
    
    // Get the users location    
    public async void seek () {
        try {
            simple = yield new GClue.Simple ("com.github.Suzie97.epoch", GClue.AccuracyLevel.CITY, null);
        } catch (Error e) {
            warning ("Failed to connect to GeoClue2 service: %s", e.message);
            return;
        }
        
        simple.notify["location"].connect (() => {
            on_location_updated.begin ();
        });

        on_location_updated.begin ();
    }
    
    public async void on_location_updated () {
        geo_location = simple.get_location ();
        
        location = location.find_nearest_city (geo_location.latitude, geo_location.longitude);
        
        if (location != null) {
            face1_label.label = dgettext ("libgweather-locations", location.get_city_name ());
        }
    }
}
