using Granite
using Gtk;

namespace Mu{
    public class Mu : Granite.Application {

        //Variables
        Window window;
        Gtk.DrawingArea graph;
        
        public Mu(){
            this.set_flags (ApplicationFlags.HANDLES_OPEN);
            Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;

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