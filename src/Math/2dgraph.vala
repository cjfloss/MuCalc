using Gtk;
namespace Pi.Math { 

	public class 2DGraph : Gtk.DrawingArea {
		//The main variables and constants
		public static const int CARTESIAN = 0;
		public static const int POLAR = 1;
		private int width;
		private int height;
		private int type;
		private double screen_scale_x = 20;
		private double screen_scale_y = 20;
		bool isPressed = false;
		Function[] functions = new Function[0];

		public 2DGraph (int type){
			add_events (Gdk.EventMask.BUTTON_PRESS_MASK
	              | Gdk.EventMask.BUTTON_RELEASE_MASK
	              | Gdk.EventMask.POINTER_MOTION_MASK);
	    	width = get_allocated_width ();
	       	height = get_allocated_height ();
	       	this.type = type;
			//if (scale == 0)
		//	{
		//		scale = 10;
		//	}
		}

		// convert coordinates to the actual x
		public double to_screen_x(double x)
		{
			return (x*scale_x + width/2);
		}

		// convert coordinates to scren y
		public double to_screen_y(double y)
		{
			return ((height/2 - y*screen_scale_y));
		}

		// convert to coordinate x
		public double to_coord_x(double x)
		{

			return ((x - width/2)/scale_x);
		}

		// convert to coordinate y
		public double to_coord_y(double y)
		{
			return ((height/2 + y)/scale_y);
		}		

		// draw the actual graph
		private void draw_graph(Cairo.Context cr){
			draw_axis(cr);
		}

		async void graph_function(Function f, Cairo.Context cr)
		{
			graph_point(0, f.evaluate_when('x', to_coord_x(0)), cr);
	  		for (double i = 0; i < width; i++)
	  		{
	  			cr.set_source_rgb(f.color.R, f.color.G, f.color.B);
	  			graph_point(i, f.evaluate_when('i', to_coord_x(i)), cr);
	  		}
		}

		//expecting graphing coordaintes, not screen ones
		void graph_point(double x, double y, Cairo.Context cr)
		{
			double xx = to_screen_x(x);
			double yy = to_screen_y(y);
		  	cr.move_to(x, yy);
		  	cr.line_to(x+1, yy);
		  	cr.stroke();
		}

		async void draw_axis(Cairo.Context cr)
		{
			width = get_allocated_width ();
	       	height = get_allocated_height ();
	  		cr.set_line_width(1);
	  		cr.set_source_rgb(1, 1, 1);
	  		cr.paint();
		    int xc = width / 2;
		    int yc = height / 2;
	        cr.set_source_rgb (0, 0, 0);
	        cr.move_to(0 , yc);
	        cr.line_to(width, yc);
	        cr.move_to(xc, 0);
	        cr.line_to(xc, height);
	        cr.stroke();
	        graph_all_functions(cr);
		   	cr.move_to(0 , yc);	    
	        cr.set_font_size(8);    		   		  
		}

		// graph the functions entered
		public void graph_all_functions(Cairo.Context cr)
		{
	  		for (int i = 0; i < functions.length; i++) {
	  			graph_function(functions[i], cr);
	  		}
		}


		// the actual widget needs o be drawn
	  	public override bool draw (Cairo.Context cr) {
	  		if (scale_y <= 0) { scale_y = 1;}
	  		if (scale_x <= 0) { scale_x = 1;}
	  		width = get_allocated_width();
	  		height = get_allocated_height();
	  		draw_graph(cr);
	  		graph_all_functions(cr);
	  		stdout.printf("scale x: " + scale_x.to_string() + "|| scale_y: " + scale_y.to_string() + "\n");
	       	return false;
	    }

		public double scale_x{
			get {return width/screen_scale_x;}
			set {screen_scale_x = width/value;}
		}	    

		public double scale_y{
			get {return height/screen_scale_y;}
			set {screen_scale_y = height/value;}
		}	    

		public double scale{
			set {screen_scale_x = width/value; screen_scale_y = height/value;}
		}	    


	    /* Mouse button got pressed over widget */
	    public override bool button_press_event (Gdk.EventButton e) {
	        // ...
	        isPressed = true;
	        stdout.printf("clicked : ");
	        stdout.printf("(" + to_coord_x(e.x).to_string() + ", " + to_coord_y(e.y).to_string() + ") \n");
	        return false;
	    }

	    /* Mouse button got released */
	    public override bool button_release_event (Gdk.EventButton e) {
	        // ...
	        isPressed = false;
	        stdout.printf("released ");
	        stdout.printf(((int)e.x).to_string());
	        stdout.printf(",");
	        stdout.printf(((int)e.y).to_string());
	        stdout.printf("\n");
	        stdout.printf("released ");
	        stdout.printf(((int) to_coord_x(e.x)).to_string());
	        stdout.printf(",");
	        stdout.printf(((int)to_coord_y(e.y)).to_string());
	        stdout.printf("\n");	        
	        return false;
	    }   

	    /* Mouse pointer moved over widget */
	    public override bool motion_notify_event (Gdk.EventMotion e) {
	        // ...
	        if (isPressed)
	        {
	        	//its dragging
	        	stdout.printf("dragged over ");
		        stdout.printf(((int)e.x).to_string());
		        stdout.printf(",");
		        stdout.printf(((int)e.y).to_string());
		        stdout.printf("\n");
		        return false;	
	        }
	        else {
	        	//its not dragging

		        return false;	
	        }
	    }

	    /*Graph a function sent by the user*/
	    public void add_function(string f)
	    {
	    	functions.resize(functions.length + 1);
	    	functions[functions.length - 1] = new Function(f);
	    }
	}
}