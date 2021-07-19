public class Epoch.Parser : GLib.Object {
    List<string> lines;
    private static Parser? parser = null;

    public static Parser get_default () {
        if (parser == null)
            parser = new Parser ();
        return parser;
    }
    private Parser () {
        var file = File.new_for_path ("/usr/share/zoneinfo/zone.tab");
        if (!file.query_exists ()) {
            critical ("/usr/share/zoneinfo/zone.tab doesn't exist !");
            return;
        }

        lines = new List<string> ();
        try {
            var dis = new DataInputStream (file.read ());
            string line;
            while ((line = dis.read_line (null)) != null) {
                if (line.has_prefix ("#")) {
                    continue;
                }

                lines.append (line);
            }
        } catch (Error e) {
            critical (e.message);
        }
#if GENERATE
        generate_translation_template ();
#endif
    }

    public HashTable<string, string> get_timezones_from_continent (string continent) {
        var timezones = new HashTable<string, string> (str_hash, str_equal);
        foreach (var line in lines) {
            var items = line.split ("\t", 4);
            string value = items[2];
            if (value.has_prefix (continent) == false)
                continue;

            string tz_name_field;
            // Take the original English string if there is something wrong with the translation
            if (_(items[2]) == null || _(items[2]) == "") {
                tz_name_field = items[2];
            } else {
                tz_name_field = _(items[2]);
            }

            string city = tz_name_field.split ("/", 2)[1];
            if (city != null && city != "") {
                string key = format_city (city);
                if (items[3] != null && items[3] != "") {
                    if (items[3] != "mainland" && items[3] != "most locations" && _(items[3]) != key) {
                        key = "%s - %s".printf (key, format_city (_(items[3])));
                    }
                }

                timezones.set (key, value);
            }
        }

        return timezones;
    }

    public HashTable<string, string> get_locations () {
        var locations = new HashTable<string, string> (str_hash, str_equal);
        foreach (var line in lines) {
            var items = line.split ("\t", 4);
            string key = items[1];
            string value = items[2];
            locations.set (key, value);
        }

        return locations;
    }

    public static string format_city (string city) {
        return city.replace ("_", " ").replace ("/", ", ");
    }

#if GENERATE
    public void generate_translation_template () {
        var file = GLib.File.new_for_path (GLib.Environment.get_home_dir () + "/Translations.vala");
        try {
            var dos = new GLib.DataOutputStream (file.create (GLib.FileCreateFlags.REPLACE_DESTINATION));
            dos.put_string ("#if 0\n");
            foreach (var line in lines) {
                var items = line.split ("\t", 4);
                string key = items[2];
                string comment = items[3];
                dos.put_string ("///Translators: Secondary \"/\" and all \"_\" will be replaced by \", \" and \" \".\n");
                dos.put_string ("_(\""+ key + "\");\n");
                if (comment != null && comment != "") {
                    dos.put_string ("///Translators: Comment for Timezone %s\n".printf (key));
                    dos.put_string ("_(\""+ comment + "\");\n");
                }
            }
            dos.put_string ("#endif\n");
        } catch (Error e) {
            critical (e.message);
        }
    }
#endif
}
