public class Epoch.PreferencesDialog : Gtk.Dialog {
    public PreferencesDialog () {
        var close_button = add_button (_("Close"), Gtk.ResponseType.CLOSE);
        ((Gtk.Button) close_button).clicked.connect (() => destroy ());
    }
}
