public class Epoch.CitiesChooser : Gtk.Grid {
    string[] cities = {"Guwahati", "Paris", "London", "New York"};
    
    public Gtk.ComboBox city1box;
    private Gtk.ComboBox city2box;
    private Gtk.ComboBox city3box;
    private Gtk.ComboBox city4box;
    
    private Gtk.ListStore liststore;
    
    // private Epoch.LabelsGrid labels;
    
    enum Column {
        CITY
    }
    
    construct {
        liststore = new Gtk.ListStore (1, typeof (string));
        
        for (int i = 0; i < cities.length; i++) {
            Gtk.TreeIter iter;
            liststore.append (out iter);
            liststore.set (iter, Column.CITY, cities[i]);
        }
        
        city1box = new Gtk.ComboBox.with_model (liststore);
        var cell1 = new Gtk.CellRendererText ();
        city1box.pack_start (cell1, false);
        city1box.set_attributes (cell1, "text", Column.CITY);
            
        city1box.set_active (0);
        
        // city1box.changed.connect (on_city1box_changed);
        
        city2box = new Gtk.ComboBox.with_model (liststore);
        var cell2 = new Gtk.CellRendererText ();
        city2box.pack_start (cell2, false);
        city2box.set_attributes (cell2, "text", Column.CITY);
        
        city2box.set_active (1);
        
        city3box = new Gtk.ComboBox.with_model (liststore);
        var cell3 = new Gtk.CellRendererText ();
        city3box.pack_start (cell3, false);
        city3box.set_attributes (cell3, "text", Column.CITY);
        
        city3box.set_active (2);
        
        city4box = new Gtk.ComboBox.with_model (liststore);
        var cell4 = new Gtk.CellRendererText ();
        city4box.pack_start (cell4, false);
        city4box.set_attributes (cell4, "text", Column.CITY);
        
        city4box.set_active (3);
        
        this.attach (city1box, 0, 0);
        this.attach (city2box, 0, 1);
        this.attach (city3box, 0, 2);
        this.attach (city4box, 0, 3);
        // this.attach (labels.face1_label, 0, 4);
    }
    
    // private void on_city1box_changed () {
    //     Gtk.TreeIter iter;
    //     Value val;
    //     
    //     city1box.get_active_iter (out iter);
    //     liststore.get_value (iter, 0, out val);
    //     
    //     stdout.printf ("Selection is '%s'\n", (string) val);
    //     labels.face1_label.set_text ((string) val);
    // }
}
