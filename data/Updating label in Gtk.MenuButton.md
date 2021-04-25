When the city is set in the location entry, the label inside the button grid needs to be updated. 

So I need to fetch the city name from the entry inside the location entry and update the label in the button grid. 

Maybe try using `get_city_name` and then using `set_label` to update the label in the button grid.

## New Plan
First run a method to get the location of the user and the time zone of the default cities.

When the label in the `menu_button` in preferences will be changed, it will not be equal to the `face1_label`.
If the label in the `menu_button` and the label in the label of face1 are not equal, run a method to set the name of face1 to match the label of the `menu_button`.

Same for the other cities as well.

## Limitations
Need to figure out, how to access the label of `location.get_city_name` or the label of the `menu_button` and use it in the other Gtk.Labels.

## To do today
Update the label in the `menu_button` when the search entry is set
