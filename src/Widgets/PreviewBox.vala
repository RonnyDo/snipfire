namespace Screenshot.Widgets {

	public class PreviewBox : Gtk.Box {
        
        Gtk.Image preview;
        Gtk.Label label;

		public PreviewBox () {

            label = new Gtk.Label("Take a screenshot.");
            this.pack_start (label);

        }
        
        public void set_canvas (Gdk.Pixbuf? screenshot) {            
            if (preview == null) {
                this.remove (label);
                preview = new Gtk.Image ();	

                Gtk.ScrolledWindow win = new Gtk.ScrolledWindow(null, null);
                win.add(preview);

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

        public Gdk.Pixbuf? get_canvas () {
            return preview.get_pixbuf();
        }

	}
}
