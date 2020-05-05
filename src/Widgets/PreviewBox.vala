namespace Screenshot.Widgets {
	public class PreviewBox : Gtk.Box {
                
        Gtk.ScrolledWindow scrolled_window;
        Gtk.Box drawing_box;

        Gtk.DrawingArea drawing_area;
        Gtk.Label info_label;
        Gdk.Pixbuf screenshot;

        Cairo.ImageSurface surface;

        EventHistory event_history = null;

        construct {
            scrolled_window = new Gtk.ScrolledWindow(null, null);
            scrolled_window.set_halign (Gtk.Align.CENTER);
            scrolled_window.set_valign (Gtk.Align.CENTER);

            scrolled_window.set_propagate_natural_height (true);
            scrolled_window.set_propagate_natural_width (true);
            
            info_label = new Gtk.Label("Take a screenshot.");     
            this.pack_start (info_label, true, true);           
            
        }

		public PreviewBox (EventHistory event_history) {
            this.event_history = event_history;
        }

        
        public void set_canvas (Gdk.Pixbuf? screenshot) {            
            this.screenshot = screenshot;

            // first screenshot
            if (drawing_area == null) {
                this.remove (info_label);

                drawing_area = new Gtk.DrawingArea ();
                register_events ();

                scrolled_window.add(drawing_area);
                
                this.pack_start (scrolled_window, true, true);        
            }

            // FIXME: Memory error when drawing on new seconds screenshot
            
            drawing_area.set_size_request (screenshot.get_width(), screenshot.get_height());
            // scrolled_window.set_max_content_width (screenshot.get_width());
            // scrolled_window.set_max_content_height (screenshot.get_height());
            
            
            // FIXME: The fillowing numbers have to be added to resize the window properly. There are guessed and 
            // I have no clue how to derive them. The following line just fixes the scrolledWindow:
            // -> scrolled_window.get_parent().set_size_request (screenshot.get_width(), screenshot.get_height());
            int ominous_width = 102;
            int ominous_height = 158;
            this.get_window().resize (screenshot.get_width() + ominous_width, screenshot.get_height() + ominous_height);                        
            
            this.show_all();
        }

        private void register_events () {
            drawing_area.add_events (Gdk.EventMask.BUTTON_PRESS_MASK |
                        Gdk.EventMask.BUTTON_RELEASE_MASK |
                        Gdk.EventMask.BUTTON_MOTION_MASK);

            drawing_area.button_press_event.connect (event_history.button_pressed);
            drawing_area.motion_notify_event.connect (event_history.motion_notified);
            drawing_area.button_release_event.connect (event_history.button_released);

            drawing_area.draw.connect (main_draw);
            
            event_history.update_event.connect(history_updated);
        }


        public Gdk.Pixbuf? get_canvas () {
            Gtk.Allocation allocation;
            get_allocation (out allocation); 

            return Gdk.pixbuf_get_from_surface(this.surface, 0, 0, allocation.width, allocation.height);
        }


        private void history_updated () {
            drawing_area.queue_draw();
        }

        public bool main_draw (Cairo.Context cr) {    
            Gtk.Allocation allocation;
            get_allocation (out allocation);   
            
            surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, allocation.width, allocation.height);
                    
            if (screenshot != null) {
                
                Cairo.Context background_context = new Cairo.Context (surface);
                Gdk.cairo_set_source_pixbuf (background_context, screenshot, 0, 0);
                background_context.paint ();

                cr.set_source_surface (background_context.get_target (), 0, 0);
                cr.paint ();	
            } else {
                warning ("Can't paint if screenshot is NULL");
            } 
            
            if (event_history != null) {                
                //Cairo.ImageSurface canvas_surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, allocation.width, allocation.height);
                Cairo.Context canvas_context = new Cairo.Context (surface);
                event_history.draw (surface, canvas_context);
                
                cr.set_source_surface (canvas_context.get_target (), 0, 0);
                cr.paint ();
            } else {
                warning ("Can't paint if event_history is NULL");
            }
            
            return false;
        }

	}
}
