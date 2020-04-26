namespace Screenshot.Widgets {
    public class Point {
		public double x;
		public double y;
		public Point (double x, double y) {
			this.x = x;
			this.y = y;
		}
    }
    
    public enum Utils {
        PENCIL,
        HIGHLIGHTER,
        ERASER
    }

    public class Path {
        public List<Point> points = null;

        public Utils util {get; set;}

        public Path (Utils util) {
            this.util = util;
        }
    }
    
    public class DrawingArea : Gtk.DrawingArea {
		//public signal void stroke_added (double[] coordinates);
		//public signal void stroke_removed (uint n_strokes);
	}

	public class PreviewBox : Gtk.Box {
        
        Gtk.Image preview;
        Gtk.DrawingArea da;
        Gtk.Label label;
        Gdk.Pixbuf screenshot;

        Utils util = PENCIL;

        Gdk.RGBA line_color = Gdk.RGBA();
        Gdk.RGBA background_color = Gdk.RGBA();
        int line_thickness = 1;

        public List<Path> paths = new List<Path> ();
        public Path current_path = null;
        
        public signal void stroke_added (double[] coordinates);

		public PreviewBox () {

            label = new Gtk.Label("Take a screenshot.");
            this.pack_start (label);
            line_color.parse("#FF0000");
            background_color.parse("#000000");

        }

        public void set_util (Utils util) {
            this.util = util;
        }
        
        public void set_canvas (Gdk.Pixbuf? screenshot) {            
            this.screenshot = screenshot;


            if (preview == null) {
                this.remove (label);

                Gtk.ScrolledWindow win = new Gtk.ScrolledWindow(null, null);
                preview = new Gtk.Image ();	
                //win.add(preview);
                da = new DrawingArea ();

                da.add_events (Gdk.EventMask.BUTTON_PRESS_MASK |
						   Gdk.EventMask.BUTTON_RELEASE_MASK |
                           Gdk.EventMask.BUTTON_MOTION_MASK);
                da.button_press_event.connect (drawing_area_button_pressed);
                da.motion_notify_event.connect (drawing_area_motion_notify_event);
                da.button_release_event.connect (drawing_area_button_released);
                da.draw.connect (main_draw);


                //win.add(preview);
                win.add(da);

                this.pack_start (win);
                this.show_all();
            }            

            int width = screenshot.get_width ();
            int height = screenshot.get_height ();
            var scale = get_style_context ().get_scale ();

            preview.set_from_pixbuf (screenshot.scale_simple (width * scale, height * scale, Gdk.InterpType.BILINEAR));
            preview.get_style_context ().set_scale (1);

            warning (width.to_string());
        }

        public int get_canvas_hash () {
            error ("TBD. e.g. to decice if canvas changed and should be saved again");
            //return 0;
        }

        public Gdk.Pixbuf? get_canvas () {
            error("TBD: get_canvas ()");
            //return preview.get_pixbuf();
        }

        public bool drawing_area_button_pressed (Gdk.EventButton e) {
            switch (util) {
                case PENCIL:
                    current_path = new Path (PENCIL);
                    current_path.points.append (new Point (e.x, e.y));
                    paths.append (current_path);
                    break;
                case HIGHLIGHTER:
                    current_path = new Path (HIGHLIGHTER);
                    current_path.points.append (new Point (e.x, e.y));
                    paths.append (current_path);
                    break;
                case ERASER:
                    current_path = new Path (ERASER);
                    current_path.points.append (new Point (e.x, e.y));
                    paths.append (current_path);
                    break;
                default:
                    break;
            }

            return false;
        }

        public bool drawing_area_button_released (Gdk.EventButton e) {
            Gtk.Allocation allocation;
            get_allocation (out allocation);

            double[] coordinates = new double[current_path.points.length () * 2];
            int i = 0;
            foreach (var point in current_path.points) {
                coordinates[i] = point.x / (double)allocation.width;
                coordinates[i + 1] = point.y / (double)allocation.height;
            }

            stroke_added (coordinates);

            current_path = null;

            return false;
        }

        public bool drawing_area_motion_notify_event (Gdk.EventMotion e) {            
            Gtk.Allocation allocation;
            get_allocation (out allocation);

            // get distane between this point and last point
            double x = e.x.clamp ((double)allocation.x, (double)(allocation.x + allocation.width));
            double y = e.y.clamp ((double)allocation.y, (double)(allocation.y + allocation.height));
            Point last = current_path.points.last ().data;
            double dx = Math.fabs(last.x - x);
            double dy = Math.fabs(last.y - y);

            // Thanks Neauoire! =)
            double err = dx + dy;
            double e2 = 2 * err;
            if (e2 >= dy) {
                err += dy; x += (x < last.x ? 1 : -1);
                current_path.points.append (new Point (x, y));
            }
              if (e2 <= dx) {
                err += dx; y += (y < last.y ? 1 : -1);
                current_path.points.append (new Point (x, y));
            }
            //

            da.queue_draw ();

            return false;
        }




        public bool main_draw (Cairo.Context cr) {    

            Gtk.Allocation allocation;
            get_allocation (out allocation);   
                    
            if (screenshot == null) {
                warning ("Can't paint if screenshot is NULL");
                return false;
            }

			Cairo.ImageSurface background_surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, allocation.width, allocation.height);
			Cairo.Context background_context = new Cairo.Context (background_surface);
            Gdk.cairo_set_source_pixbuf (background_context, screenshot, 0, 0);
            background_context.paint ();

            cr.set_source_surface (background_context.get_target (), 0, 0);
			//cr.rectangle (0, 0, allocation.width, allocation.height); ???
            cr.paint ();			 
            
			Cairo.ImageSurface canvas_surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, allocation.width, allocation.height);
			Cairo.Context canvas_context = new Cairo.Context (canvas_surface);
            draws (canvas_context);
            
			cr.set_source_surface (canvas_context.get_target (), 0, 0);
			//cr.rectangle (0, 0, allocation.width, allocation.height);
            cr.paint ();
            
            return false;
        }


        /*
		private void draw_grid (Cairo.Context cr) {
            if (screenshot == null) {
                warning ("IS NULL");
            }
            Gdk.cairo_set_source_pixbuf (cr, screenshot, screenshot.get_width(), screenshot.get_height());
            cr.paint ();
		} */
        

        public void draws (Cairo.Context cr) {
			cr.set_antialias (Cairo.Antialias.SUBPIXEL);
			cr.set_fill_rule (Cairo.FillRule.EVEN_ODD);
			cr.set_line_cap (Cairo.LineCap.ROUND);
			cr.set_line_join (Cairo.LineJoin.ROUND);
			foreach (var path in paths) {
                switch (path.util) {
                    case PENCIL:
                        Gdk.cairo_set_source_rgba (cr, line_color);
                        cr.set_line_width (line_thickness);
                        Point first = path.points.first ().data;
                        cr.move_to (first.x, first.y);
                        foreach (var point in path.points.next) {
                            cr.line_to (point.x, point.y);
                        }
                        cr.stroke ();
                        break;
                    case HIGHLIGHTER:
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
                        break;
                    case ERASER:
                        Gdk.cairo_set_source_rgba (cr, background_color);
                        cr.set_line_width (9);
                        Point first = path.points.first ().data;
                        cr.move_to (first.x, first.y);
                        foreach (var point in path.points.next) {
                            cr.line_to (point.x, point.y);
                        }
                        cr.stroke ();
                        break;
                    default:
                        break;
                }
			}
		}

	}
}
