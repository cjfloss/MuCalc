using Gtk;
using Mu.Math;
namespace Mu.Math { 

	public class 2DGraph : Gtk.DrawingArea {
		//The main variables and constants
		public static const int CARTESIAN = 0;
		public static const int POLAR = 1;
		private int width;
		private int height;
		private int type;
		private double scale;
		bool isPressed = false;

		Function[] functions = new Function[0];

		public 2DGraph (){
			add_events (Gdk.EventMask.BUTTON_PRESS_MASK
	              | Gdk.EventMask.BUTTON_RELEASE_MASK
	              | Gdk.EventMask.POINTER_MOTION_MASK);
	    	width = get_allocated_width ();
	       	height = get_allocated_height ();
			this.type = type;
			if (scale == 0)
			{
				scale = 10;
			}

		}

		// convert coordinates to the actual x
		public double to_x(double x)
		{
			return ((x + width/2)*scale);
		}

		// convert coordinates to actual y
		public double to_y(double y)
		{
			return ((y + height/2)*scale);
		}

		// convert to coordinate x
		public double to_coord_x(double x)
		{
			return ((x - width/2)/scale);
		}

		// convert to coordinate y
		public double to_coord_y(double y)
		{
			return ((height/2 - y)/scale);
		}

		// draw the actual graph
		private void draw_graph(Cairo.Context cr){
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
		}

		// graph the functions entered
		public void graph_functions(Cairo.Context cr)
		{
	  		for (int i = 0; i < functions.length; i++) {
	  			int fx = 0;
	  			int result;
	  			//while (fx < width)
	  			//{
	  			//	fx++;
	  			//}
	  		}
		}


		// the actual widget needs o be drawn
	  	public override bool draw (Cairo.Context cr) {
	  		draw_graph(cr);
	  		graph_functions(cr);

	       	return false;
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