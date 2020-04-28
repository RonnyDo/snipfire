namespace Screenshot.Widgets {
	public class PreviewBox : Gtk.Box {
        
        Gtk.Image preview;
        Gtk.DrawingArea drawing_area;
        Gtk.Label info_label = new Gtk.Label("Take a screenshot.");
        Gdk.Pixbuf screenshot;

        EventHistory event_history = new EventHistory (new Pencil());      

		public PreviewBox () {
            info_label = new Gtk.Label("Take a screenshot.");
            this.pack_start (info_label);
        }

        
        public void set_canvas (Gdk.Pixbuf? screenshot) {            
            this.screenshot = screenshot;

            if (drawing_area == null) {
                this.remove (info_label);

                Gtk.ScrolledWindow win = new Gtk.ScrolledWindow(null, null);
                
                drawing_area = new Gtk.DrawingArea ();

                drawing_area.add_events (Gdk.EventMask.BUTTON_PRESS_MASK |
						   Gdk.EventMask.BUTTON_RELEASE_MASK |
                           Gdk.EventMask.BUTTON_MOTION_MASK);
                register_events ();
                drawing_area.draw.connect (main_draw);
                
                win.add(drawing_area);

                this.pack_start (win);
                this.show_all();
            } 
        }

        private void register_events () {
            drawing_area.button_press_event.connect (event_history.button_pressed);
            drawing_area.motion_notify_event.connect (event_history.motion_notified);
            drawing_area.button_release_event.connect (event_history.button_released);
            
            event_history.update_event.connect(history_updated);
        }

        public int get_canvas_hash () {
            error ("TBD. e.g. to decice if canvas changed and should be saved again");
            //return 0;
        }


        public Gdk.Pixbuf? get_canvas () {
            error("TBD: get_canvas ()");
            //return preview.get_pixbuf();
        }


        private void history_updated () {
            drawing_area.queue_draw();
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
            cr.paint ();			 
            
			Cairo.ImageSurface canvas_surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, allocation.width, allocation.height);
			Cairo.Context canvas_context = new Cairo.Context (canvas_surface);
            event_history.draw (canvas_context);
            
			cr.set_source_surface (canvas_context.get_target (), 0, 0);
            cr.paint ();
            
            return false;
        }

	}
}
