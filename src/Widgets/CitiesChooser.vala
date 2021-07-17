/* CitiesChooser.vala
 *
 * Copyright 2021 Rajdeep Singha <singharajdeep97@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Epoch.CitiesChooser : Gtk.MenuButton {
	private Epoch.CitiesSearch cities_search;

	private Epoch.LabelsGrid labels_grid;

	public Gtk.Label button_label;

	construct {
	    margin = 5;
		labels_grid = new Epoch.LabelsGrid ();

		var button_grid = new Gtk.Grid ();
		button_grid.column_spacing = 6;
		// button_label = new Gtk.Label (labels_grid.face1_label.get_text ());
		button_label = new Gtk.Label ("Dimapur");
		button_grid.add (button_label);
		button_grid.add (new Gtk.Image.from_icon_name ("pan-down-symbolic", Gtk.IconSize.MENU));
		add (button_grid);

		cities_search = new Epoch.CitiesSearch ();
		cities_search.show_all ();

		cities_search.location_entry.activate.connect ((obj) => {
			button_label.set_text (cities_search.location_entry.get_text ());
			labels_grid.face1_label.set_text (cities_search.location_entry.get_text ());
			if (this.get_active ()) {
				this.set_active (false);
			}
		});

		popover = new Gtk.Popover (this);
		popover.add (cities_search);
	}
}

// public class Epoch.CitiesChooser : Gtk.Grid {
//     string[] cities = {"Guwahati", "Paris", "London", "New York"};
//
//     public Gtk.ComboBox city1box;
//     private Gtk.ComboBox city2box;
//     private Gtk.ComboBox city3box;
//     private Gtk.ComboBox city4box;
//
//     private Gtk.ListStore liststore;
//
//     // private Epoch.LabelsGrid labels;
//
//     enum Column {
//         CITY
//     }
//
//     construct {
//         liststore = new Gtk.ListStore (1, typeof (string));
//
//         for (int i = 0; i < cities.length; i++) {
//             Gtk.TreeIter iter;
//             liststore.append (out iter);
//             liststore.set (iter, Column.CITY, cities[i]);
//         }
//
//         city1box = new Gtk.ComboBox.with_model (liststore);
//         var cell1 = new Gtk.CellRendererText ();
//         city1box.pack_start (cell1, false);
//         city1box.set_attributes (cell1, "text", Column.CITY);
//
//         city1box.set_active (0);
//
//         // city1box.changed.connect (on_city1box_changed);
//
//         city2box = new Gtk.ComboBox.with_model (liststore);
//         var cell2 = new Gtk.CellRendererText ();
//         city2box.pack_start (cell2, false);
//         city2box.set_attributes (cell2, "text", Column.CITY);
//
//         city2box.set_active (1);
//
//         city3box = new Gtk.ComboBox.with_model (liststore);
//         var cell3 = new Gtk.CellRendererText ();
//         city3box.pack_start (cell3, false);
//         city3box.set_attributes (cell3, "text", Column.CITY);
//
//         city3box.set_active (2);
//
//         city4box = new Gtk.ComboBox.with_model (liststore);
//         var cell4 = new Gtk.CellRendererText ();
//         city4box.pack_start (cell4, false);
//         city4box.set_attributes (cell4, "text", Column.CITY);
//
//         city4box.set_active (3);
//
//         this.attach (city1box, 0, 0);
//         this.attach (city2box, 0, 1);
//         this.attach (city3box, 0, 2);
//         this.attach (city4box, 0, 3);
//         // this.attach (labels.face1_label, 0, 4);
//     }
//
//     // private void on_city1box_changed () {
//     //     Gtk.TreeIter iter;
//     //     Value val;
//     //
//     //     city1box.get_active_iter (out iter);
//     //     liststore.get_value (iter, 0, out val);
//     //
//     //     stdout.printf ("Selection is '%s'\n", (string) val);
//     //     labels.face1_label.set_text ((string) val);
//     // }
// }
