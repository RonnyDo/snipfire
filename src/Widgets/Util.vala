namespace Screenshot.Widgets { 
    
    public abstract class Util : Object {
        public abstract void draw (Cairo.Context cr, List<Point> points);
        public Cairo.Operator operator_type { get; set; default = Cairo.Operator.ADD; }  
    }


    public class Pencil : Util {
        public Gdk.RGBA color = Gdk.RGBA(); 
        public int size { get; set; default=5;}

        construct {
            // red as default color
            color.parse("#FF0000");
            this.operator_type = Cairo.Operator.OVER;
        }

        public override void draw (Cairo.Context cr, List<Point> points) {            
            cr.set_antialias (Cairo.Antialias.SUBPIXEL);
			cr.set_fill_rule (Cairo.FillRule.EVEN_ODD);
			cr.set_line_cap (Cairo.LineCap.ROUND);
            cr.set_line_join (Cairo.LineJoin.ROUND);
            cr.set_operator (this.operator_type);


            cr.new_path();
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


    public class Rectangle : Util {
        public Gdk.RGBA color = Gdk.RGBA(); 
        public int size { get; set; default=5;}

        construct {
            // red as default color
            color.parse("#FF0000");
            this.operator_type = Cairo.Operator.OVER;
        }

        public override void draw (Cairo.Context cr, List<Point> points) {            
            cr.set_antialias (Cairo.Antialias.NONE);
			cr.set_fill_rule (Cairo.FillRule.EVEN_ODD);
			cr.set_line_cap (Cairo.LineCap.SQUARE);
            cr.set_line_join (Cairo.LineJoin.MITER);
            cr.set_operator (this.operator_type);


            cr.new_path();
            Gdk.cairo_set_source_rgba (cr, color);
            cr.set_line_width (size);

            Point first = points.first ().data;
            Point last = points.last().data;

            cr.rectangle (first.x, first.y, last.x - first.x, last.y - first.y);
            cr.move_to (first.x, first.y);            
            cr.stroke ();
        }
    }


    public class Highlighter : Util {
        public Gdk.RGBA color = Gdk.RGBA(); 
        public int size { get; set; default = 30; }
        public double alpha {get; set; default = 0.3; }

        construct {
            // red as default color
            color.parse("#FFFF00");
            color.alpha = this.alpha;
            this.operator_type = Cairo.Operator.SOURCE;
        }

        public override void draw (Cairo.Context cr, List<Point> points) {
            cr.set_antialias (Cairo.Antialias.SUBPIXEL);
			cr.set_fill_rule (Cairo.FillRule.EVEN_ODD);
			cr.set_line_cap (Cairo.LineCap.BUTT);
            cr.set_line_join (Cairo.LineJoin.BEVEL);
            //cr.set_operator (Cairo.Operator.HARD_LIGHT); -> okish:HARD_LIGHT,SOFT_LIGHT, LIGHTEN, XOR, MULTIPLY, SOURCE 
            cr.set_operator (this.operator_type);

            cr.new_path();
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

    

    public class Eraser : Util {
        public Gdk.RGBA color = Gdk.RGBA(); 
        public int size { get; set; default = 20;}

        construct {
            // red as default color
            color.parse("#000000");
            this.operator_type = Cairo.Operator.CLEAR;
        }

        public override void draw (Cairo.Context cr, List<Point> points) {            
            cr.set_antialias (Cairo.Antialias.SUBPIXEL);
			cr.set_fill_rule (Cairo.FillRule.EVEN_ODD);
			cr.set_line_cap (Cairo.LineCap.ROUND);
            cr.set_line_join (Cairo.LineJoin.ROUND);
            cr.set_operator (this.operator_type);
            
            cr.new_path();
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
}