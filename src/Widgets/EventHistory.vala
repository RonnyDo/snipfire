namespace Screenshot.Widgets { 
    
    public class Point {
		public double x;
		public double y;
		public Point (double x, double y) {
			this.x = x;
			this.y = y;
		}
    }

    public class HistoryEntry {
        public List<Point> points = null;

        public Util util { get; set;}

        public HistoryEntry (Util util) {
            this.util = util;
        }

        public void draw (Cairo.Context cr) {
            util.draw (cr, points);
        }
    }

    public class EventHistory {
        public HistoryEntry current_event = null;
        public List<HistoryEntry> event_entries = new List<HistoryEntry> ();

        Util current_util = null;

        // might be interesting for updating the GUI
        public signal void stroke_added (double[] coordinates);

        // update history, e.g. if drawing begun
        public signal void update_event ();

        public EventHistory (Util util) {
            this.current_util = util;
        }
        
        public void set_util (Util util) {
            this.current_util = util;
        }

        public void clear () {
            // clears the history;
            current_event = null;
            event_entries = new List<HistoryEntry> ();
            update_event ();
        }

        public void undo () {
            event_entries.remove_link (event_entries.last());
            update_event ();
        }

        public bool button_pressed (Gtk.Widget widget, Gdk.EventButton event_button) {
            current_event = new HistoryEntry (this.current_util);
            current_event.points.append (new Point (event_button.x, event_button.y));
            event_entries.append (current_event);

            return false;
        }


        public bool button_released (Gtk.Widget widget, Gdk.EventButton event_button) {
            Gtk.Allocation allocation;
            widget.get_allocation (out allocation);

            double[] coordinates = new double[current_event.points.length () * 2];
            int i = 0;
            foreach (var point in current_event.points) {
                coordinates[i] = point.x / (double)allocation.width;
                coordinates[i + 1] = point.y / (double)allocation.height;
            }

            stroke_added (coordinates);
            update_event ();

            current_event = null;

            return false;
        }


        public bool motion_notified (Gtk.Widget widget, Gdk.EventMotion event_motion) {
            Gtk.Allocation allocation;
            widget.get_allocation (out allocation);

            // get distane between this point and last point
            double x = event_motion.x.clamp ((double)allocation.x, (double)(allocation.x + allocation.width));
            double y = event_motion.y.clamp ((double)allocation.y, (double)(allocation.y + allocation.height));
            Point last = current_event.points.last ().data;
            double dx = Math.fabs(last.x - x);
            double dy = Math.fabs(last.y - y);

            // Thanks Neauoire! =)
            double err = dx + dy;
            double e2 = 2 * err;
            if (e2 >= dy) {
                err += dy; x += (x < last.x ? 1 : -1);
                current_event.points.append (new Point (x, y));
            }
              if (e2 <= dx) {
                err += dx; y += (y < last.y ? 1 : -1);
                current_event.points.append (new Point (x, y));
            }

            update_event ();

            return false;
        }

        public void draw (Cairo.ImageSurface sf, Cairo.Context cr) {
            Cairo.ImageSurface highlighter_surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, sf.get_width(), sf.get_height());
            Cairo.Context highlighter_context = new Cairo.Context (highlighter_surface);

            Cairo.ImageSurface solid_surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, sf.get_width(), sf.get_height());
            Cairo.Context solid_context = new Cairo.Context (solid_surface);


            foreach (var event in event_entries) {
                switch (event.util.operator_type) {
                    case Cairo.Operator.CLEAR:
                        // erase on all contextes
                        event.draw (highlighter_context);
                        event.draw (solid_context);
                        break;
                    case Cairo.Operator.SOURCE: 
                        // highlights are of type source:
                        event.draw (highlighter_context);
                        break;
                    default:
                        // all others to solid context
                        event.draw (solid_context);
                        break;
                }
            }

            cr.set_operator (Cairo.Operator.OVER);
            cr.set_source_surface (highlighter_context.get_target (), 0, 0);
            cr.paint();

            cr.set_operator (Cairo.Operator.OVER);
            cr.set_source_surface (solid_context.get_target (), 0, 0);
            cr.paint();

        }
    }
}