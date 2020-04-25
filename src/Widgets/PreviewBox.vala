namespace Screenshot.Widgets {

	public class PreviewBox : Gtk.Box {
        
        Gtk.Image preview;
        Gtk.Label label;

		public PreviewBox () {

            label = new Gtk.Label("Take a screenshot.");
            this.pack_start (label);

        }
        
        public void update (Gdk.Pixbuf? screenshot) {            
            if (preview == null) {
                this.remove (label);
                preview = new Gtk.Image ();	
                this.pack_start (preview);
                this.show_all();
            }            

            int width = screenshot.get_width ();
            int height = screenshot.get_height ();
            var scale = get_style_context ().get_scale ();

            preview.gicon = screenshot.scale_simple (width * scale, height * scale, Gdk.InterpType.BILINEAR);
            preview.get_style_context ().set_scale (1);

            warning (width.to_string());
        }
	}
}