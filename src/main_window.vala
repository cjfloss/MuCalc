using Granite;
using Gtk;
using Pi.Math;
using Granite.Widgets;
namespace Pi{
    public class Main : Granite.Application {

        //Variables
        Window window;
        2DGraph graph;
        Toolbar toolbar;
        public const bool GRAPH_MODE = true;
        public const bool SOLVE_MODE = false;
        public bool mode;
        ToolButton switch_btn;
        ToolButton zoom_out;
        ToolButton zoom_in;
        Box mainBox = new Box (Orientation.VERTICAL, 0);
        Box verticalBox = new Gtk.Box (Orientation.VERTICAL, 0);
        ThinPaned main_hpaned = new ThinPaned ();
        Welcome welcome_scr;
        public Main(){
            this.set_flags (ApplicationFlags.HANDLES_OPEN);
            Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;

        }

    construct {
        program_name = "Pi";
        exec_name = "pi_calculator";
        app_years = "2013";
        app_icon = "application-pi-calc";
        app_launcher = "Pi.desktop";
        application_id = "com.antwankakki.pi";

        main_url = "https://code.launchpad.net/mu-calc";
        bug_url = "https://bugs.launchpad.net/mu-calc";
        help_url = "https://code.launchpad.net/mu-calc";
        translate_url = "https://translations.launchpad.net/mu-calc";

        about_authors = {"Antwan Gaggi <antwankakki@gmail.com>"};
        about_documenters = {"Antwan Gaggi <antwankakki@gmail.com>"};
        about_artists = {"Antwan Gaggi"};
        about_comments = "A powerful advanced graphing caclulator";
        about_translators = "";
        about_license_type = License.GPL_3_0;
    }


        public static int main (string [] args){
            Gtk.init (ref args);
            var pi = new Pi.Main ();
            return pi.run (args);
        }

        public override void activate () {
            if (this.window == null)
            build_and_run ();
        }

        public void build_and_run () {
            this.window = new Window ();
            this.window.set_default_size (800, 600);
            this.window.set_position(WindowPosition.CENTER);
            this.window.set_application (this);
            this.window.set_title("π Calculator");

            //The uppermost layout (Toolbar + Rest)
            var menu = new Gtk.Menu ();
            var appmenu   = this.create_appmenu (menu);
            toolbar   = new Toolbar ();
            var backward    = new ToolButton (new Image.from_icon_name ("go-previous", IconSize.BUTTON), "");
            var forward   = new ToolButton (new Image.from_icon_name ("go-next", IconSize.BUTTON), "");
            zoom_in = new ToolButton (new Image.from_icon_name("zoom-in", IconSize.BUTTON), "");
            zoom_out = new ToolButton (new Image.from_icon_name("zoom-out", IconSize.BUTTON), "");
            var text_box = new ToolItem ();
            var expander = new ToolItem ();
            graph = new 2DGraph(2DGraph.CARTESIAN);
            expander.set_expand (true);

            //Welcome Screen
            Welcome welcome_scr = new Welcome("Welcome to π", "choose your next step...");
            welcome_scr.append_with_image(new Image.from_icon_name("document-page-setup", IconSize.BUTTON),
                "Graph 2D", "Graph 2D cartesian, polar, or hyperbolic equations.");
            welcome_scr.append_with_image(new Image.from_icon_name("document-page-setup", IconSize.BUTTON),
                "Graph 3D", "Graph 3D cartesian, polar, or hyperbolic equations.");
            welcome_scr.append_with_image(new Image.from_icon_name("format-justify-fill", IconSize.BUTTON),
                "Solve", "Solve, Integrate, Derive, and do much more with π.");
            welcome_scr.append_with_image(new Image.from_icon_name("preferences-system", IconSize.BUTTON),
                "Settings", "Access π's Settings.");

            welcome_scr.activated.connect ((i) => {
                    if (i == 0){
                        mainBox.remove(welcome_scr);
                        mainBox.pack_start(graph, true);
                        mainBox.show_all();
                    }
                    else if (i == 1) {

                    }
                    else if (i == 2) {

                    }
                });

            //Insert to toolbar
            toolbar.insert (backward, 0);
            toolbar.insert (forward, 1);
            toolbar.insert (zoom_in, 2);
            toolbar.insert (zoom_out, 3) ;
            toolbar.insert (expander, 4);

               // deal with gui later
                switch_btn = new ToolButton (new Image.from_icon_name("format-justify-fill", IconSize.BUTTON), "");
            toolbar.insert (switch_btn, 5);
            toolbar.insert (appmenu, 6);
            toolbar.get_style_context ().add_class ("primary-toolbar");

            zoom_in.clicked.connect ( () => {
                this.graph.scale_x = this.graph.scale_x + 10;
                this.graph.scale_y = this.graph.scale_y + 10;
                mainBox.show_all();
            });

            zoom_out.clicked.connect ( () => {
                this.graph.scale_x = this.graph.scale_x - 10;
                this.graph.scale_y = this.graph.scale_y - 10;

                mainBox.show_all();
            });


            switch_btn.clicked.connect ( () => {
                this.switch_mode();
            });

            graph.add_function("y=x^(2)"); 
            zoom_out.hide();
            zoom_in.hide();
            switch_btn.hide();
            mainBox.pack_start (toolbar, false);
            mainBox.pack_start(welcome_scr, true);
            window.add (mainBox);
            mainBox.show_all();
            window.show_all ();
            switch_mode();
            zoom_out.hide();
            zoom_in.hide();
            switch_btn.hide();
        }

        private void switch_mode () {
            if(mode != GRAPH_MODE){
                switch_btn = new ToolButton (new Image.from_icon_name("format-justify-fill", IconSize.BUTTON), "");
            }
            else {
                switch_btn = new ToolButton (new Image.from_icon_name("document-page-setup", IconSize.BUTTON), "");
            }
            mode = !mode;
        }
    }
}
