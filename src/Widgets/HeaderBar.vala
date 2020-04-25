
// source https://github.com/aimproxy/dotfonts/blob/master/src/Widgets/HeaderBar.vala
namespace Screenshot.Widgets {

	public class HeaderBar : Gtk.HeaderBar {
		
		Gtk.Image take_screenshot_icon;
		public Gtk.Button take_screenshot_button;


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
			take_screenshot_button.tooltip_text = "Take Screenshot";			

		    this.pack_start (take_screenshot_button);

		}
	}
}
