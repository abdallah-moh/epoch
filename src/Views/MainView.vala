public class Epoch.MainView : Gtk.Grid {
    
    construct {
        var labels = new Epoch.LabelsGrid ();
        
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
        
        var grid = new Gtk.Grid ();
        grid.column_spacing = 12;
        grid.margin = 24;
        grid.attach (grid_face1, 0, 0, 1, 2);
        grid.attach (grid_face2, 1, 0, 1, 2);
        grid.attach (grid_face3, 2, 0, 1, 2);
        grid.attach (grid_face4, 3, 0, 1, 2);
        
        add (grid);
    }
}
