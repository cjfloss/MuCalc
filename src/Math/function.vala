using Gtk;
using Pi.Math;
using Granite.Drawing;
namespace Pi.Math {

    public class Function : Object {

        public string originalFunction;
        //each variable has a sign and a power
        // the index one is the sign index, variables at 0 are positive, at 1 are negative
        // second index is the power, the third one is the actual variable one.

        public Expression right_expression;
        public Expression left_expression;
        public Color color;
        public static int color_int;
        public static string[] color_set = {"red", "blue", "green", "yellow","orange", "pink", "purple"};


        public Function(string f)
        {
            double r = Random.double_range(0.1,0.95);
            double g = Random.double_range(0.1,0.95);
            double b = Random.double_range(0.1,0.95);
            double a = Random.double_range(0.90, 0.97);
            color = new Color(r,g,b,a);

            originalFunction = f;
            parse_function(); // get the variables in the function
        }

        public string solve_for(char letter)
        {
            return "";
        }


        public void parse_function()
        {
         string[] f = originalFunction.split_set("=");
         stdout.printf("Parsing function \"" + originalFunction + "\" \n");
         // split at the place where we have an equal sign
            stdout.printf("Assigned left expression to \"" + f[0] + "\" \n");
            left_expression = new Expression(f[0]);
            stdout.printf("Assigned right expression to \"" + f[1] + "\" \n");
            right_expression = new Expression(f[1]);
        }

        public double evaluate_when(char letter, double number)
        {
            //only evaluates values on the right
            //TODO: complete solving mechanism
            if (number.to_string().char_count() > 5)
            {
            stdout.printf("\x1b[32m" + "evaluating function \"\x1b[33m" +
                                     originalFunction + "\x1b[32m\"for when \"\x1b[33m" +
                                     letter.to_string() + "\"\x1b[32m is \"\x1b[33m" + number.to_string() +
                                      "\x1b[32m\" \n\x1b[0m");
                                      }
            double result = 0;
            //solve_for(letter);
            result = right_expression.evaluate_when(letter, number);
            return result;
        }

    }
}
