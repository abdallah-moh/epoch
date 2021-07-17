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

using GLib;
using Cairo;
using Gtk;

public class ClockFaces : DrawingArea {

    private Time time ;
    private int minute_offset ;

    public signal void time_changed (int hour, int minute) ;

     public ClockFaces () {
        update () ;

        Timeout.add (1000, update) ;

        set_size_request (100, 100) ;
    }

    public override bool draw (Cairo.Context cr) {
        int y = get_allocated_height () / 2 ;
        int x = get_allocated_width ()  / 2 ;
        var radius = double.min (get_allocated_width () / 2,
                                 get_allocated_height () / 2) - 5 ;

        // Base Circle
        cr.arc (x, y, radius, 0, 2 * Math.PI);
        cr.set_source_rgb (256, 256, 256);
        cr.fill ();

        // Base Circle Border
        cr.arc (x, y, radius + 2, 0, 2 * Math.PI);
        cr.set_source_rgb (0, 0, 0);
        cr.stroke ();

        // Center Circle
        cr.set_source_rgb (0, 0, 0);
        cr.set_line_width (1);
        cr.arc (x, y, 3, 0, 2 * Math.PI);
        cr.stroke ();

        // Clock Ticks
        for (int i = 0; i < 12; i++) {
            int inset;

            cr.save ();

            if (i % 3 == 0) {
                inset = (int) (0.2 * radius);
            } else {
                inset = (int) (0.1 * radius);
                /* line width is temporary, replace with numbers when possible */
                // cr.set_line_width (0.5 * cr.get_line_width ()) ;
                // cr.set_line_width (0);
            }

            cr.move_to (x + (radius - inset) * Math.cos (i * Math.PI / 6),
                        y + (radius - inset) * Math.sin (i * Math.PI / 6));
            cr.line_to (x + radius * Math.cos (i * Math.PI / 6),
                        y + radius * Math.sin (i * Math.PI / 6));
            cr.set_source_rgb (1, 0.2, 0.2);
            cr.set_line_width (2);
            cr.stroke ();
            cr.restore ();
        }

        // Clock Hands
        var hours = this.time.hour ;
        var minutes = this.time.minute + this.minute_offset ;
        var seconds = this.time.second ;

        /* Hour Hand: the hour hand is rotated 30 degrees (pi/6r) per hour + 1/2 a degree (pi/360r) per minute */
        cr.save () ;
        cr.set_line_width (3); //subject to change
        cr.move_to (x, y) ;
        cr.line_to (x + radius / 2 * Math.sin (Math.PI / 6 * hours
                                             + Math.PI / 360 * minutes),
                    y + radius / 2 * Math.cos (Math.PI / 6 * hours
                                              + Math.PI / 360 * minutes));
        cr.stroke ();
        cr.restore ();

        /* Minute Hand: the minute hand is rotated 6 degrees (pi/30 r) per minute */
        cr.move_to (x, y);
        cr.line_to (x + radius * 0.75 * Math.sin (Math.PI / 30 * minutes),
                    y + radius * 0.75 * -Math.cos (Math.PI / 30 * minutes));
        cr.stroke ();

        /* seconds Hand: operates identically to the minute hand */
        cr.save ();
        cr.set_source_rgb (1, 0, 0); // red
        cr.move_to (x, y);
        cr.line_to (x + radius * 0.7 * Math.sin (Math.PI / 30 * seconds),
                    y + radius * 0.7 * -Math.cos (Math.PI / 30 * seconds));
        cr.stroke ();
        cr.restore ();

        return false ;
    }

    private bool update () {
        // update the time
        this.time = Time.local (time_t ());
        redraw_canvas ();
        return true;        // keep running this event
    }

    private void redraw_canvas () {
        var window = get_window ();
        if (null == window) {
            return;
        }

        var region = window.get_clip_region ();
        // redraw the cairo canvas completely by exposing it
        window.invalidate_region (region, true);
    }
}
