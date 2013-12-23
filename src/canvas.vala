using Granite
using Gtk;

namespace Mu{
    public class Canvas : Gtk.DrawingArea {

        int[] x-axis;
        int[] y-axis;


        public Canvas(){
            x-axis[0] = 0;
            x-axis[1] = ((int)(get_allocated_height()/2));
            x-axis[2] = get_allocated_width();
            x-axis[3] = ((int)(get_allocated_height()/2));
        }

            /* Widget is asked to draw itself */
      public override bool draw (Cairo.Context cr) {
            cr.set_source_rgb (0, 0, 0);
            cr.set_line_width (4);
            cr.set_tolerance (0.1);

             return false;
            }

        public static int main (string [] args){
            Gtk.init (ref args);
            var mu = new Mu.Mu ();
            return mu.run (args);
        }

        public override void activate () {
            if (this.main_window == null)
            build_and_run ();
        }

        public void build_and_run () {
            this.window = new Window ();
            this.window.set_default_size (640, 480);
            this.window.set_application (this);
            graph = new graph(600,480);
            //hello world
            var label = new Label ("Hello world");
            this.main_window.add (label);
            this.main_window.show_all ();
        }

    }
}
