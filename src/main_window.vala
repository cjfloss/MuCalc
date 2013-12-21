using Granite;
using Gtk;

namespace Mu{
    public class Main : Granite.Application {

        //Variables
        Window window;
        DrawingArea graph;
        Toolbar toolbar;

        public Main(){
            this.set_flags (ApplicationFlags.HANDLES_OPEN);
            Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;

        }

    construct {
        program_name = "Mu";
        exec_name = "mu_calculator";
        app_years = "2013";
        app_icon = "application-default-icon";
        app_launcher = "Mu.desktop";
        application_id = "com.antwankakki.mu";

        main_url = "https://code.launchpad.net/hello_world";
        bug_url = "https://bugs.launchpad.net/hello_world";
        help_url = "https://code.launchpad.net/hello_world";
        translate_url = "https://translations.launchpad.net/hello_world";

        about_authors = {"Antwan Gaggi <antwankakki@gmail.com>"};
        about_documenters = {"Antwan Gaggi <antwankakki@gmail.com>"};
        about_artists = {"Antwan Gaggi"};
        about_comments = "A powerful advanced graphing caclulator";
        about_translators = "";
        about_license_type = License.GPL_3_0;
    }


        public static int main (string [] args){
            Gtk.init (ref args);
            var mu = new Mu.Main ();
            return mu.run (args);
        }

        public override void activate () {
            if (this.window == null)
            build_and_run ();
        }

        public void build_and_run () {
            this.window = new Window ();
            this.window.set_default_size (640, 480);
            this.window.set_application (this);
            //The uppermost layout (Toolbar + Rest)
            var mainBox = new Box (Orientation.VERTICAL, 0);
            var innerBox = new Box (Orientation.HORIZONTAL, 0);
            var menu = new Gtk.Menu ();
            var appmenu   = this.create_appmenu (menu);
            toolbar = new Toolbar();
            mainBox.pack_start(toolbar, false);
            toolbar.get_style_context ().add_class ("primary-toolbar");
            toolbar.insert(appmenu, 0);
            mainBox.add(toolbar);
            mainBox.add(innerBox);
            //Inner Layout (Graph and equations)
            var graph = new DrawingArea();
            innerBox.add(graph);


            this.window.add (mainBox);
            this.window.show_all ();
        }

    }
}
