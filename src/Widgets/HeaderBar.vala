
// source https://github.com/aimproxy/dotfonts/blob/master/src/Widgets/HeaderBar.vala
namespace Screenshot.Widgets {

	public class HeaderBar : Gtk.HeaderBar {
		
		Gtk.Image take_screenshot_icon;
		public Gtk.Button take_screenshot_button;

		Gtk.Image copy_to_clipboard_icon;
		public Gtk.Button copy_to_clipboard_button;


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
			take_screenshot_button.set_always_show_image (true);
			copy_to_clipboard_button.tooltip_text = "Copy to clipboard";	

			this.pack_start (take_screenshot_button);
			this.pack_start (copy_to_clipboard_button);

		}
	}
}
