namespace Screenshot.Widgets { 
    public abstract class Util : Object {
        public abstract void draw (Cairo.Context cr, List<Point> points);
    }

    public class Pencil : Util {
        public Gdk.RGBA color = Gdk.RGBA(); 
        public int size { get; set; default=5;}

        construct {
            // red as default color
            color.parse("#FF0000");
        }

        public override void draw (Cairo.Context cr, List<Point> points) {
            cr.set_antialias (Cairo.Antialias.SUBPIXEL);
			cr.set_fill_rule (Cairo.FillRule.EVEN_ODD);
			cr.set_line_cap (Cairo.LineCap.ROUND);
            cr.set_line_join (Cairo.LineJoin.ROUND);

            Gdk.cairo_set_source_rgba (cr, color);
            cr.set_line_width (size);
            Point first = points.first ().data;
            cr.move_to (first.x, first.y);
            foreach (var point in points.next) {
                cr.line_to (point.x, point.y);
            }
            cr.stroke ();
        }
    }

    /*
    public class Highlighter : Util {
        public string color { get; set; default="#00FF00"; }
        public int size { get; set; default=3; }        

        public override void draw (Cairo.Context cr, List<Point> points) {
            cr.set_antialias (Cairo.Antialias.SUBPIXEL);
			cr.set_fill_rule (Cairo.FillRule.EVEN_ODD);
			cr.set_line_cap (Cairo.LineCap.ROUND);
            cr.set_line_join (Cairo.LineJoin.ROUND);

            Gdk.cairo_set_source_rgba (cr, line_color);
            cr.set_line_width (9);
            foreach (var point in path.points.next) {
                cr.rectangle (point.x, point.y, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 3, point.y, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 6, point.y, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 9, point.y, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 2, point.y + 3, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 5, point.y + 3, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 8, point.y + 3, 1, 1);
                cr.fill ();
                cr.rectangle (point.x, point.y + 6, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 3, point.y + 6, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 6, point.y + 6, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 9, point.y + 6, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 2, point.y + 9, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 5, point.y + 9, 1, 1);
                cr.fill ();
                cr.rectangle (point.x + 8, point.y + 9, 1, 1);
                cr.fill ();
            }
            cr.stroke ();
        }
    }

    public class Eraser : Util {
        public int size { get; set; default=3; }     

        public override void draw (Cairo.Context cr, List<Point> points) {
            cr.set_antialias (Cairo.Antialias.SUBPIXEL);
			cr.set_fill_rule (Cairo.FillRule.EVEN_ODD);
			cr.set_line_cap (Cairo.LineCap.ROUND);
            cr.set_line_join (Cairo.LineJoin.ROUND);

            Gdk.cairo_set_source_rgba (cr, background_color);
            cr.set_line_width (9);
            Point first = path.points.first ().data;
            cr.move_to (first.x, first.y);
            foreach (var point in path.points.next) {
                cr.line_to (point.x, point.y);
            }
            cr.stroke ();
        }
        
    }
    */
}