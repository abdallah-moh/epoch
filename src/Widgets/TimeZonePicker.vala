// public class Epoch.TimeZonePicker : Gtk.Grid {
//     private Gtk.ListStore continent_list_store;
//     private Gtk.ListStore city_list_store;
//     private Gtk.TreeView continent_view;
//     private Gtk.TreeView city_view;

//     private Gtk.Label label;
//     private string old_selection;
//     public string current_tz;
//     private bool setting_cities = false;

//     public string time_zone {
//         set {
//             set_timezone (value);
//         }
//     }

//     construct {
//         label = new Gtk.Label ("");

//         continent_list_store = new Gtk.ListStore (2, typeof (string), typeof (string));
//         continent_list_store.set_default_sort_func ((model, a, b) => {
//             Value value_a;
//             Value value_b;
//             model.get_value (a, 0, out value_a);
//             model.get_value (b, 0, out value_b);
//             return value_a.get_string ().collate (value_b.get_string ());
//         });

//         continent_list_store.set_sort_column_id (Gtk.TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID, Gtk.SortType.ASCENDING);

//         continent_view = new Gtk.TreeView () {
//             model = continent_list_store,
//             headers_visible = false
//         };
//         continent_view.get_style_context ().add_class (Gtk.STYLE_CLASS_SIDEBAR);
//         continent_view.get_selection ().mode = Gtk.SelectionMode.SINGLE;

//         var continent_cell_renderer = new Gtk.CellRendererText () {
//             xpad = 12
//         };

//         continent_view.insert_column_with_attributes (-1, null, continent_cell_renderer, "text", 1);

//         Gtk.TreeIter iter;
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "Africa");
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "America");
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "Antarctica");
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "Asia");
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "Atlantic");
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "Australia");
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "Indian");
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "Europe");
//         continent_list_store.append (out iter);
//         continent_list_store.set (iter, 1, "Pacific");

//         continent_view.get_selection ().changed.connect (() => {
//             Gtk.TreeIter activated_iter;
//             Gtk.TreeModel model;
//             string continent;
//             if (continent_view.get_selection ().get_selected (out model, out activated_iter)) {
//                 model.get (activated_iter, 1, out continent);
//                 if (old_selection != continent) {
//                     change_city_from_continent (continent);
//                     old_selection = continent;
//                 }
//             }
//         });

//         city_list_store = new Gtk.ListStore (2, typeof (string), typeof (string));
//         city_list_store.set_default_sort_func ((model, a, b) => {
//             Value value_a;
//             Value value_b;
//             model.get_value (a, 0, out value_a);
//             model.get_value (b, 0, out value_b);
//             return value_a.get_string ().collate (value_b.get_string ());
//         });

//         city_list_store.set_sort_column_id (Gtk.TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID, Gtk.SortType.ASCENDING);

//         city_view = new Gtk.TreeView () {
//             model = city_list_store,
//             headers_visible = false
//         };

//         var city_cellrenderer = new Gtk.CellRendererText () {
//             ellipsize_set = true,
//             width_chars = 50,
//             wrap_mode = Pango.WrapMode.WORD_CHAR,
//             ellipsize = Pango.EllipsizeMode.END
//         };
//         city_view.insert_column_with_attributes (-1, null, city_cellrenderer, "text", 1);
//         city_view.get_selection ().changed.connect (() => {
//             if (setting_cities == true)
//                 return;

//             Gtk.TreeIter activated_iter;
//             Gtk.TreeModel model;
//             if (city_view.get_selection ().get_selected (out model, out activated_iter)) {
//                 model.get (activated_iter, 1, out current_tz);
//                 label.set_text (current_tz);
//             }
//         });

//         var city_scrolled = new Gtk.ScrolledWindow (null, null) {
//             hexpand = true
//         };
//         city_scrolled.add (city_view);
//         city_scrolled.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);

//         var main_grid = new Gtk.Grid ();
//         main_grid.add (continent_view);
//         main_grid.add (new Gtk.Separator (Gtk.Orientation.VERTICAL));
//         main_grid.add (city_scrolled);
//         main_grid.attach (label, 0, 1);

//         add (main_grid);
//     }

//     public void set_timezone (string tz) {
//         current_tz = tz;
//         var values = tz.split ("/", 3);
//         continent_list_store.@foreach ((model, path, iter) => {
//             Value value;
//             model.get_value (iter, 1, out value);
//             if (values[0] == value.get_string ()) {
//                 continent_view.get_selection ().select_iter (iter);
//                 return true;
//             }

//             return false;
//         });
//     }

//     private void change_city_from_continent (string continent) {
//         setting_cities = true;
//         city_list_store.clear ();
//         Parser.get_default ().get_timezones_from_continent (continent).foreach ((key, value) => {
//             Gtk.TreeIter iter;
//             city_list_store.append (out iter);
//             city_list_store.set (iter, 0, key, 1, value);
//             if (current_tz == value) {
//                 city_view.get_selection ().select_iter (iter);
//                 city_view.scroll_to_cell (city_list_store.get_path (iter), null, false, 0, 0);
//             }
//         });

//         setting_cities = false;
//     }
// }

// /*
//  * SPDX-License-Identifier: GPL-3.0-or-later
//  * SPDX-FileCopyrightText: 2021 Your Name <singharajdeep97@gmail.com>
//  */

public class Epoch.TimeZonePicker : Gtk.Grid {
    public signal void request_timezone_change (string tz);

    private const string AFRICA = "Africa";
    private const string AMERICA = "America";
    private const string ANTARCTICA = "Antarctica";
    private const string ASIA = "Asia";
    private const string ATLANTIC = "Atlantic";
    private const string AUSTRALIA = "Australia";
    private const string EUROPE = "Europe";
    private const string INDIAN = "Indian";
    private const string PACIFIC = "Pacific";
    Gtk.TreeView continent_view;
    Gtk.ListStore continent_list_store;
    Gtk.TreeView city_view;
    Gtk.ListStore city_list_store;
    string old_selection;
    public string current_tz;
    bool setting_cities = false;
    public string city;

    // public string time_zone {
    //     set {
    //         set_timezone (value);
    //     }
    // }

    public TimeZonePicker () {
        var main_grid = new Gtk.Grid ();
        var label = new Gtk.Label ("");
        continent_list_store = new Gtk.ListStore (2, typeof (string), typeof (string));
        continent_list_store.set_default_sort_func ((model, a, b) => {
            Value value_a;
            Value value_b;
            model.get_value (a, 0, out value_a);
            model.get_value (b, 0, out value_b);
            return value_a.get_string ().collate (value_b.get_string ());
        });

        continent_list_store.set_sort_column_id (Gtk.TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID, Gtk.SortType.ASCENDING);
        Gtk.TreeIter iter;
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("Africa"), 1, AFRICA);
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("America"), 1, AMERICA);
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("Antarctica"), 1, ANTARCTICA);
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("Asia"), 1, ASIA);
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("Atlantic"), 1, ATLANTIC);
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("Australia"), 1, AUSTRALIA);
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("Europe"), 1, EUROPE);
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("Indian"), 1, INDIAN);
        continent_list_store.append (out iter);
        continent_list_store.set (iter, 0, _("Pacific"), 1, PACIFIC);

        continent_view = new Gtk.TreeView.with_model (continent_list_store);
        continent_view.get_style_context ().add_class ("sidebar");
        continent_view.headers_visible = false;
        continent_view.get_selection ().mode = Gtk.SelectionMode.BROWSE;

        var cellrenderer = new Gtk.CellRendererText ();
        cellrenderer.xpad = 12;
        continent_view.insert_column_with_attributes (-1, null, cellrenderer, "text", 0);
        continent_view.get_selection ().changed.connect (() => {
            Gtk.TreeIter activated_iter;
            Gtk.TreeModel model;
            string continent;
            if (continent_view.get_selection ().get_selected (out model, out activated_iter)) {
                model.get (activated_iter, /*1*/1, out continent);
                if (old_selection != continent) {
                    change_city_from_continent (continent);
                    old_selection = continent;
                }
            }
            // if (continent_view.get_selection ().get_selected (null, out activated_iter)) {
            //     Value value;
            //     continent_list_store.get_value (activated_iter, 1, out value);
            //     if (old_selection != value.get_string ()) {
            //         change_city_from_continent (value.get_string ());
            //         old_selection = value.get_string ();
            //     }
            // }

        });

        city_list_store = new Gtk.ListStore (2, typeof (string), typeof (string));
        city_list_store.set_default_sort_func ((model, a, b) => {
            Value value_a;
            Value value_b;
            model.get_value (a, 0, out value_a);
            model.get_value (b, 0, out value_b);
            return value_a.get_string ().collate (value_b.get_string ());
        });

        city_list_store.set_sort_column_id (Gtk.TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID, Gtk.SortType.ASCENDING);
        city_view = new Gtk.TreeView.with_model (city_list_store);
        city_view.headers_visible = false;

        var city_cellrenderer = new Gtk.CellRendererText ();
        city_cellrenderer.ellipsize_set = true;
        city_cellrenderer.width_chars = 50;
        city_cellrenderer.wrap_mode = Pango.WrapMode.WORD_CHAR;
        city_cellrenderer.ellipsize = Pango.EllipsizeMode.END;
        city_view.insert_column_with_attributes (-1, null, city_cellrenderer, "text", 0);
        city_view.get_selection ().changed.connect (() => {
            // if (setting_cities == true)
            //     return;

            // Gtk.TreeIter activated_iter;
            // Gtk.TreeModel model;
            // if (city_view.get_selection ().get_selected (out model, out activated_iter)) {
            //     Value value;
            //     city_list_store.get_value (activated_iter, 1, out value);
            //     request_timezone_change (value.get_string ());
            //     current_tz = value.get_string ();
            // }
            if (setting_cities == true)
                return;

            Gtk.TreeIter activated_iter;
            Gtk.TreeModel model;
            if (city_view.get_selection ().get_selected (out model, out activated_iter)) {
                model.get (activated_iter, /*Column.CITY*/1, out current_tz);
                label.set_text (current_tz.substring (current_tz.index_of_char ('/', 0) + 1));
            }
        });

        // int start = current_tz.index_of_char ('/', 0);
        // city = current_tz.substring (start);
        // label.set_text (ci);

        var city_scrolled = new Gtk.ScrolledWindow (null, null);
        city_scrolled.add (city_view);
        city_scrolled.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
        city_scrolled.hexpand = true;

        main_grid.add (continent_view);
        main_grid.add (new Gtk.Separator (Gtk.Orientation.VERTICAL));
        main_grid.add (city_scrolled);
        main_grid.attach (label, 0, 1);
        main_grid.show_all ();

        add (main_grid);
    }

    // public void set_timezone (string tz) {
    //     current_tz = tz;
    //     var values = tz.split ("/", 3);
    //     continent_list_store.@foreach ((model, path, iter) => {
    //         Value value;
    //         model.get_value (iter, 1, out value);
    //         if (values[0] == value.get_string ()) {
    //             continent_view.get_selection ().select_iter (iter);
    //             return true;
    //         }

    //         return false;
    //     });
    // }

    private void change_city_from_continent (string continent) {
        setting_cities = true;
        city_list_store.clear ();
        Parser.get_default ().get_timezones_from_continent (continent).foreach ((key, value) => {
            Gtk.TreeIter iter;
            city_list_store.append (out iter);
            city_list_store.set (iter, 0, key, 1, value);
            if (current_tz == value) {
                city_view.get_selection ().select_iter (iter);
                city_view.scroll_to_cell (city_list_store.get_path (iter), null, false, 0, 0);
            }
        });

        setting_cities = false;
    }
}
