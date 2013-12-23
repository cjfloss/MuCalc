using Granite;
using Gtk;
using Mu.Widgets;
namespace Mu{
    public class Main : Granite.Application {

        //Variables
        Window window;
        Graph graph;
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
            this.window.set_title("Mu Caclulator");
            //The uppermost layout (Toolbar + Rest)
            var mainBox = new Box (Orientation.VERTICAL, 0);
            var menu = new Gtk.Menu ();
            var appmenu   = this.create_appmenu (menu);
            toolbar   = new Toolbar ();
            var backward    = new ToolButton (new Image.from_stock (Stock.GO_BACK, IconSize.BUTTON), "");
            var forward   = new ToolButton (new Image.from_stock (Stock.GO_FORWARD, IconSize.BUTTON), "");
            var expander      = new ToolItem ();
            var export      = new ToolButton (new Image.from_icon_name ("document-export", IconSize.BUTTON), "");
            graph = new Graph(Graph.TWO_DIMENSIONAL);

            expander.set_expand (true);

            toolbar.insert (backward, 0);
            toolbar.insert (forward, 1);
            toolbar.insert (expander, 2);
            toolbar.insert (export, 3);
            toolbar.insert (appmenu, 4);
            toolbar.get_style_context ().add_class ("primary-toolbar");
        
            mainBox.pack_start (toolbar, false);
            mainBox.pack_start(graph, true);
            window.add (mainBox);
            mainBox.show_all();
            window.show_all ();
        }

    }
}