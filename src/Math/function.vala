using Gtk;
using Pi.Math;
using Granite.Drawing;
namespace Pi.Math {

    public class Function : Object {

        public string originalFunction;
        //each variable has a sign and a power
        // the index one is the sign index, variables at 0 are positive, at 1 are negative
        // second index is the power, the third one is the actual variable one.

        Gee.ArrayList<Variable> right_list = new Gee.ArrayList<Variable>();
        Gee.ArrayList<Variable> left_list = new Gee.ArrayList<Variable>();
        public Color color;
        public static int color_int;
        public static string[] color_set = {"red", "blue", "green", "yellow",
                                            "orange", "pink", "purple"};
        public Function(string f)
        {
            double r = Random.double_range(0.1,0.95);
            double g = Random.double_range(0.1,0.95);
            double b = Random.double_range(0.1,0.95);
            double a = Random.double_range(0.90, 0.97);
            color = new Color(r,g,b,a);

            originalFunction = f;
            parse_terms(); // get the variables in the function
        }

        public string solve_for(char letter)
        {
            return "";
        }

        public double evaluate_when(char letter, double number)
        {
            //only evaluates values on the right
            //TODO: complete solving mechanism

            double result = 0;
            double answer = 0;
            solve_for(letter);
            for (int i = 0; i < right_list.to_array().length; i++) {
                    answer = GLib.Math.pow(number, double.parse(right_list[i].power));
                
                if (right_list[i].is_negative) {
                    result = result - answer;
                }
                else {
                    result = result + answer;
                }
            }
            return result;
        }





        public void parse_terms()
        {
            bool left_side = true;
            string f = originalFunction;
            int var_index = 0;
            for (int i = 0; i < f.char_count(); i++) {
                if (f.get_char(i) == '=')
                {
                    left_side = false;
                }
                if (f.get_char(i).to_string() in GLib.CharacterSet.a_2_z || f.get_char(i).to_string() in GLib.CharacterSet.A_2_Z)
                {
                    char sind = '+'; // sign
                    string pind = "1"; // power

                    if (f.get_char(i-1) == '-') // check if the variable is negative
                    {
                        sind = '-';
                    }
                    if (f.get_char(i+1) == '^') {
                        if (f.get_char(i+2) == '(') {
                            string contents = "";
                            int ii = 1;
                            while(f.get_char(i+ii) != ')')
                            {
                                contents = contents + f.get_char(i+ii).to_string();
                                ii++;
                            }
                            pind = contents;
                        }
                        else {
                            pind = f.get_char(i+2).to_string();
                        }
                    }
                    try {
                        Variable v = new Variable.with_letter(sind, f.get_char(i), pind);
                        if(left_side)
                        {
                            left_list.add(v);
                        }
                        else {
                            right_list.add(v);
                        }
                    } catch (VariableError e) {
                        stdout.printf("variable error");
                    }
                }
            }
        }

    }
}