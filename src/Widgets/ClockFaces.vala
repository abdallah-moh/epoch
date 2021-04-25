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
    private bool dragging ;
    
    public signal void time_changed (int hour, int minute) ;
    
     public ClockFaces () {
        add_events (Gdk.EventMask.BUTTON_PRESS_MASK
                  | Gdk.EventMask.BUTTON_RELEASE_MASK
                  | Gdk.EventMask.POINTER_MOTION_MASK); 
        update () ;
        
        Timeout.add (1000, update) ;
    
        set_size_request (100, 100) ;
    }
    
    public override bool draw (Cairo.Context cr) {
        int y = get_allocated_height () / 2 ;
        int x = get_allocated_width ()  / 2 ;
        var radius = double.min (get_allocated_width () / 2,
                                 get_allocated_height () / 2) - 5 ;
                                 
        // clock back
        cr.arc (x, y, radius, 0, 2 * 3.14);
        cr.set_source_rgb (0, 0, 0);
        cr.fill_preserve ();
        cr.set_source_rgb (245, 245, 245);
        cr.stroke () ;
        
        // clock ticks
        for (int i = 0; i < 12; i++) {
            int inset ;
            
            cr.save () ;
            
            if (i % 3 == 0) {
                inset = (int) (0.2 * radius) ;
            } else {
                inset = (int) (0.1 * radius) ;
                /* line width is temporary, replace with numbers when possible */
                // cr.set_line_width (0.5 * cr.get_line_width ()) ;
                // cr.set_line_width (0);
            }
            
            cr.move_to (x + (radius - inset) * Math.cos (i * Math.PI / 6),
                        y + (radius - inset) * Math.sin (i * Math.PI / 6));
            cr.line_to (x + radius * Math.cos (i * Math.PI / 6),
                        y + radius * Math.sin (i * Math.PI / 6));
            cr.set_source_rgb (245, 245, 245) ;
            cr.stroke ();
            cr.restore ();
        }
        
        // clock hands
        var hours = this.time.hour ;
        var minutes = this.time.minute + this.minute_offset ;
        var seconds = this.time.second ;
        
        /* hour hand: the hour hand is rotated 30 degrees (pi/6r) per hour + 1/2 a degree (pi/360r) per minute */
        cr.save () ;
        // cr.set_line_width (2.5 * cr.get_line_width ()) ;
        cr.set_line_width (5); //subject to change
        cr.move_to (x, y) ;
        cr.line_to (x + radius / 2 * Math.sin (Math.PI / 6 * hours
                                             + Math.PI / 360 * minutes),
                    y + radius / 2 * Math.cos (Math.PI / 6 * hours
                                              + Math.PI / 360 * minutes));
        cr.stroke ();
        cr.restore ();

        /*minute hand: the minute hand is rotated 6 degrees (pi/30 r) per minute */
        cr.move_to (x, y);
        cr.line_to (x + radius * 0.75 * Math.sin (Math.PI / 30 * minutes),
                    y + radius * 0.75 * -Math.cos (Math.PI / 30 * minutes));
        cr.stroke ();
                        
        /* seconds hand: operates identically to the minute hand */
        cr.save ();
        cr.set_source_rgb (1, 0, 0); // red
        cr.move_to (x, y);
        cr.line_to (x + radius * 0.7 * Math.sin (Math.PI / 30 * seconds),
                    y + radius * 0.7 * -Math.cos (Math.PI / 30 * seconds));
        cr.stroke ();
        cr.restore ();
        
        return false ;
    }
    
    public override bool button_press_event (Gdk.EventButton event) {
        var minutes = this.time.minute + this.minute_offset;

        /* From http://mathworld.wolfram.com/Point-LineDistance2-Dimensional.html */
        var px = event.x - get_allocated_width () / 2;
        var py = get_allocated_height () / 2 - event.y;
        var lx = Math.sin (Math.PI / 30 * minutes);
        var ly = Math.cos (Math.PI / 30 * minutes);
        var u = lx * px + ly * py;

        // on opposite side of origin
        if (u < 0) {
            return false;
        }

        var d2 = Math.pow (px - u * lx, 2) + Math.pow (py - u * ly, 2);
        
        if (d2 < 25) {      // 5 pixels away from the line
            this.dragging = true;
            print ("got minute hand\n");
        }

        return false;
    }

    public override bool button_release_event (Gdk.EventButton event) {
        if (this.dragging) {
            this.dragging = false;
            emit_time_changed_signal ((int) event.x, (int) event.y);
        }
        return false;
    }

    public override bool motion_notify_event (Gdk.EventMotion event) {
        if (this.dragging) {
            emit_time_changed_signal ((int) event.x, (int) event.y);
        }
        return false;
    }

    private void emit_time_changed_signal (int x, int y) {
        // decode the minute hand
        // normalise the coordinates around the origin
        x -= get_allocated_width () / 2;
        y -= get_allocated_height () / 2;

        // phi is a bearing from north clockwise, use the same geometry as
        // we did to position the minute hand originally
        var phi = Math.atan2 (x, -y);
        if (phi < 0) {
            phi += Math.PI * 2;
        }

        var hour = this.time.hour;
        var minute = (int) (phi * 30 / Math.PI);
        
        // update the offset
        this.minute_offset = minute - this.time.minute;
        redraw_canvas ();

        time_changed (hour, minute);
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
