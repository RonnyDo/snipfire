
// source https://github.com/aimproxy/dotfonts/blob/master/src/Widgets/HeaderBar.vala
namespace Screenshot.Widgets {

	public class HeaderBar : Gtk.HeaderBar {
		
		Gtk.Image take_screenshot_icon;
		public Gtk.Button take_screenshot_button;

		Gtk.Image copy_to_clipboard_icon;
		public Gtk.Button copy_to_clipboard_button;

		Gtk.Image save_icon;
		public Gtk.Button save_button;

		Gtk.Image undo_icon;
		public Gtk.Button undo_button;

		Gtk.Image select_freehand_tool_icon;
		public Gtk.Button select_freehand_tool_button;

		Gtk.Image select_highlighter_tool_icon;
		public Gtk.Button select_highlighter_tool_button;

		Gtk.Image select_rectangle_tool_icon;
		public Gtk.Button select_rectangle_tool_button;

		Gtk.Image select_eraser_tool_icon;
		public Gtk.Button select_eraser_tool_button;


		public HeaderBar () {
		    this.show_close_button = true;
		    this.set_title ("TBD. Snipfire");

		    take_screenshot_icon = new Gtk.Image ();
		    take_screenshot_icon.gicon = new ThemedIcon ("applets-screenshooter");
		    take_screenshot_icon.pixel_size = 24;

		    take_screenshot_button = new Gtk.Button ();
		    take_screenshot_button.relief = Gtk.ReliefStyle.NONE;
			take_screenshot_button.set_label ("New");
			take_screenshot_button.set_image (take_screenshot_icon);
			take_screenshot_button.set_always_show_image (true);
			take_screenshot_button.tooltip_text = "Take screenshot";

			copy_to_clipboard_icon = new Gtk.Image ();
		    copy_to_clipboard_icon.gicon = new ThemedIcon ("edit-copy");
		    copy_to_clipboard_icon.pixel_size = 24;

			copy_to_clipboard_button = new Gtk.Button ();
		    copy_to_clipboard_button.relief = Gtk.ReliefStyle.NONE;
			copy_to_clipboard_button.set_image (copy_to_clipboard_icon);
			copy_to_clipboard_button.set_always_show_image (true);
			copy_to_clipboard_button.tooltip_text = "Copy to clipboard";	

			save_icon = new Gtk.Image ();
		    save_icon.gicon = new ThemedIcon ("document-save-as");
		    save_icon.pixel_size = 24;

			save_button = new Gtk.Button ();
		    save_button.relief = Gtk.ReliefStyle.NONE;
			save_button.set_image (save_icon);
			save_button.set_always_show_image (true);
			save_button.tooltip_text = "save";		

			undo_icon = new Gtk.Image ();
		    undo_icon.gicon = new ThemedIcon ("edit-undo");
		    undo_icon.pixel_size = 24;

			undo_button = new Gtk.Button ();
		    undo_button.relief = Gtk.ReliefStyle.NONE;
			undo_button.set_image (undo_icon);
			undo_button.set_always_show_image (true);
			undo_button.tooltip_text = "Undo";			

			select_freehand_tool_icon = new Gtk.Image ();
		    select_freehand_tool_icon.gicon = new ThemedIcon ("draw-freehand");
		    select_freehand_tool_icon.pixel_size = 24;

			select_freehand_tool_button = new Gtk.Button ();
		    select_freehand_tool_button.relief = Gtk.ReliefStyle.NONE;
			select_freehand_tool_button.set_image (select_freehand_tool_icon);
			select_freehand_tool_button.set_always_show_image (true);
			select_freehand_tool_button.tooltip_text = "Freehand";

			select_highlighter_tool_icon = new Gtk.Image ();
		    select_highlighter_tool_icon.gicon = new ThemedIcon ("draw-freehand");
		    select_highlighter_tool_icon.pixel_size = 24;

			select_highlighter_tool_button = new Gtk.Button ();
		    select_highlighter_tool_button.relief = Gtk.ReliefStyle.NONE;
			select_highlighter_tool_button.set_image (select_highlighter_tool_icon);
			select_highlighter_tool_button.set_always_show_image (true);
			select_highlighter_tool_button.tooltip_text = "Highlighter";

			select_rectangle_tool_icon = new Gtk.Image ();
		    select_rectangle_tool_icon.gicon = new ThemedIcon ("draw-freehand");
		    select_rectangle_tool_icon.pixel_size = 24;

			select_rectangle_tool_button = new Gtk.Button ();
		    select_rectangle_tool_button.relief = Gtk.ReliefStyle.NONE;
			select_rectangle_tool_button.set_image (select_rectangle_tool_icon);
			select_rectangle_tool_button.set_always_show_image (true);
			select_rectangle_tool_button.tooltip_text = "Rectangle";

			select_eraser_tool_icon = new Gtk.Image ();
		    select_eraser_tool_icon.gicon = new ThemedIcon ("draw-eraser");
		    select_eraser_tool_icon.pixel_size = 24;

			select_eraser_tool_button = new Gtk.Button ();
		    select_eraser_tool_button.relief = Gtk.ReliefStyle.NONE;
			select_eraser_tool_button.set_image (select_eraser_tool_icon);
			select_eraser_tool_button.set_always_show_image (true);
			select_eraser_tool_button.tooltip_text = "Eraser";	


			this.pack_start (take_screenshot_button);
			this.pack_start (copy_to_clipboard_button);
			this.pack_start (save_button);
			this.pack_start (undo_button);
			this.pack_start (select_freehand_tool_button);
			this.pack_start (select_highlighter_tool_button);
			this.pack_start (select_rectangle_tool_button);
			this.pack_start (select_eraser_tool_button);
		}
	}
}
