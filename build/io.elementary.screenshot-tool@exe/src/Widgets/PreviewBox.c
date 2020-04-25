/* PreviewBox.c generated by valac 0.40.19, the Vala compiler
 * generated from PreviewBox.vala, do not modify */



#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>
#include <gdk-pixbuf/gdk-pixbuf.h>
#include <gio/gio.h>


#define SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX (screenshot_widgets_preview_box_get_type ())
#define SCREENSHOT_WIDGETS_PREVIEW_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX, ScreenshotWidgetsPreviewBox))
#define SCREENSHOT_WIDGETS_PREVIEW_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX, ScreenshotWidgetsPreviewBoxClass))
#define SCREENSHOT_WIDGETS_IS_PREVIEW_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX))
#define SCREENSHOT_WIDGETS_IS_PREVIEW_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX))
#define SCREENSHOT_WIDGETS_PREVIEW_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX, ScreenshotWidgetsPreviewBoxClass))

typedef struct _ScreenshotWidgetsPreviewBox ScreenshotWidgetsPreviewBox;
typedef struct _ScreenshotWidgetsPreviewBoxClass ScreenshotWidgetsPreviewBoxClass;
typedef struct _ScreenshotWidgetsPreviewBoxPrivate ScreenshotWidgetsPreviewBoxPrivate;
enum  {
	SCREENSHOT_WIDGETS_PREVIEW_BOX_0_PROPERTY,
	SCREENSHOT_WIDGETS_PREVIEW_BOX_NUM_PROPERTIES
};
static GParamSpec* screenshot_widgets_preview_box_properties[SCREENSHOT_WIDGETS_PREVIEW_BOX_NUM_PROPERTIES];
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))

struct _ScreenshotWidgetsPreviewBox {
	GtkBox parent_instance;
	ScreenshotWidgetsPreviewBoxPrivate * priv;
};

struct _ScreenshotWidgetsPreviewBoxClass {
	GtkBoxClass parent_class;
};

struct _ScreenshotWidgetsPreviewBoxPrivate {
	GtkImage* preview;
	GtkLabel* label;
};


static gpointer screenshot_widgets_preview_box_parent_class = NULL;

GType screenshot_widgets_preview_box_get_type (void) G_GNUC_CONST;
#define SCREENSHOT_WIDGETS_PREVIEW_BOX_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX, ScreenshotWidgetsPreviewBoxPrivate))
ScreenshotWidgetsPreviewBox* screenshot_widgets_preview_box_new (void);
ScreenshotWidgetsPreviewBox* screenshot_widgets_preview_box_construct (GType object_type);
void screenshot_widgets_preview_box_update (ScreenshotWidgetsPreviewBox* self,
                                            GdkPixbuf* screenshot);
static void screenshot_widgets_preview_box_finalize (GObject * obj);


ScreenshotWidgetsPreviewBox*
screenshot_widgets_preview_box_construct (GType object_type)
{
	ScreenshotWidgetsPreviewBox * self = NULL;
	GtkLabel* _tmp0_;
	GtkLabel* _tmp1_;
#line 8 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	self = (ScreenshotWidgetsPreviewBox*) g_object_new (object_type, NULL);
#line 10 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp0_ = (GtkLabel*) gtk_label_new ("Take a screenshot.");
#line 10 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	g_object_ref_sink (_tmp0_);
#line 10 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_g_object_unref0 (self->priv->label);
#line 10 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	self->priv->label = _tmp0_;
#line 11 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp1_ = self->priv->label;
#line 11 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	gtk_box_pack_start ((GtkBox*) self, (GtkWidget*) _tmp1_, TRUE, TRUE, (guint) 0);
#line 8 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	return self;
#line 80 "PreviewBox.c"
}


ScreenshotWidgetsPreviewBox*
screenshot_widgets_preview_box_new (void)
{
#line 8 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	return screenshot_widgets_preview_box_construct (SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX);
#line 89 "PreviewBox.c"
}


void
screenshot_widgets_preview_box_update (ScreenshotWidgetsPreviewBox* self,
                                       GdkPixbuf* screenshot)
{
	GtkImage* _tmp0_;
	gint width = 0;
	gint height = 0;
	gint scale = 0;
	GtkStyleContext* _tmp7_;
	GtkImage* _tmp8_;
	GdkPixbuf* _tmp9_;
	GdkPixbuf* _tmp10_;
	GtkImage* _tmp11_;
	GtkStyleContext* _tmp12_;
	gchar* _tmp13_;
	gchar* _tmp14_;
#line 15 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	g_return_if_fail (self != NULL);
#line 16 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp0_ = self->priv->preview;
#line 16 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	if (_tmp0_ == NULL) {
#line 115 "PreviewBox.c"
		GtkLabel* _tmp1_;
		GtkImage* _tmp2_;
		GtkScrolledWindow* win = NULL;
		GtkScrolledWindow* _tmp3_;
		GtkScrolledWindow* _tmp4_;
		GtkImage* _tmp5_;
		GtkScrolledWindow* _tmp6_;
#line 17 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		_tmp1_ = self->priv->label;
#line 17 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		gtk_container_remove ((GtkContainer*) self, (GtkWidget*) _tmp1_);
#line 18 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		_tmp2_ = (GtkImage*) gtk_image_new ();
#line 18 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		g_object_ref_sink (_tmp2_);
#line 18 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		_g_object_unref0 (self->priv->preview);
#line 18 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		self->priv->preview = _tmp2_;
#line 20 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		_tmp3_ = (GtkScrolledWindow*) gtk_scrolled_window_new (NULL, NULL);
#line 20 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		g_object_ref_sink (_tmp3_);
#line 20 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		win = _tmp3_;
#line 21 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		_tmp4_ = win;
#line 21 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		_tmp5_ = self->priv->preview;
#line 21 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		gtk_container_add ((GtkContainer*) _tmp4_, (GtkWidget*) _tmp5_);
#line 23 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		_tmp6_ = win;
#line 23 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		gtk_box_pack_start ((GtkBox*) self, (GtkWidget*) _tmp6_, TRUE, TRUE, (guint) 0);
#line 24 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		gtk_widget_show_all ((GtkWidget*) self);
#line 16 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
		_g_object_unref0 (win);
#line 155 "PreviewBox.c"
	}
#line 27 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	width = gdk_pixbuf_get_width (screenshot);
#line 28 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	height = gdk_pixbuf_get_height (screenshot);
#line 29 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp7_ = gtk_widget_get_style_context ((GtkWidget*) self);
#line 29 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	scale = gtk_style_context_get_scale (_tmp7_);
#line 31 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp8_ = self->priv->preview;
#line 31 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp9_ = gdk_pixbuf_scale_simple (screenshot, width * scale, height * scale, GDK_INTERP_BILINEAR);
#line 31 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp10_ = _tmp9_;
#line 31 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	g_object_set (_tmp8_, "gicon", (GIcon*) _tmp10_, NULL);
#line 31 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_g_object_unref0 (_tmp10_);
#line 32 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp11_ = self->priv->preview;
#line 32 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp12_ = gtk_widget_get_style_context ((GtkWidget*) _tmp11_);
#line 32 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	gtk_style_context_set_scale (_tmp12_, 1);
#line 34 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp13_ = g_strdup_printf ("%i", width);
#line 34 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_tmp14_ = _tmp13_;
#line 34 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	g_warning ("PreviewBox.vala:34: %s", _tmp14_);
#line 34 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_g_free0 (_tmp14_);
#line 189 "PreviewBox.c"
}


static void
screenshot_widgets_preview_box_class_init (ScreenshotWidgetsPreviewBoxClass * klass)
{
#line 3 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	screenshot_widgets_preview_box_parent_class = g_type_class_peek_parent (klass);
#line 3 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	g_type_class_add_private (klass, sizeof (ScreenshotWidgetsPreviewBoxPrivate));
#line 3 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	G_OBJECT_CLASS (klass)->finalize = screenshot_widgets_preview_box_finalize;
#line 202 "PreviewBox.c"
}


static void
screenshot_widgets_preview_box_instance_init (ScreenshotWidgetsPreviewBox * self)
{
#line 3 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	self->priv = SCREENSHOT_WIDGETS_PREVIEW_BOX_GET_PRIVATE (self);
#line 211 "PreviewBox.c"
}


static void
screenshot_widgets_preview_box_finalize (GObject * obj)
{
	ScreenshotWidgetsPreviewBox * self;
#line 3 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, SCREENSHOT_WIDGETS_TYPE_PREVIEW_BOX, ScreenshotWidgetsPreviewBox);
#line 5 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_g_object_unref0 (self->priv->preview);
#line 6 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	_g_object_unref0 (self->priv->label);
#line 3 "/home/ronny/Downloads/snipfire/src/Widgets/PreviewBox.vala"
	G_OBJECT_CLASS (screenshot_widgets_preview_box_parent_class)->finalize (obj);
#line 227 "PreviewBox.c"
}


GType
screenshot_widgets_preview_box_get_type (void)
{
	static volatile gsize screenshot_widgets_preview_box_type_id__volatile = 0;
	if (g_once_init_enter (&screenshot_widgets_preview_box_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (ScreenshotWidgetsPreviewBoxClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) screenshot_widgets_preview_box_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (ScreenshotWidgetsPreviewBox), 0, (GInstanceInitFunc) screenshot_widgets_preview_box_instance_init, NULL };
		GType screenshot_widgets_preview_box_type_id;
		screenshot_widgets_preview_box_type_id = g_type_register_static (gtk_box_get_type (), "ScreenshotWidgetsPreviewBox", &g_define_type_info, 0);
		g_once_init_leave (&screenshot_widgets_preview_box_type_id__volatile, screenshot_widgets_preview_box_type_id);
	}
	return screenshot_widgets_preview_box_type_id__volatile;
}



