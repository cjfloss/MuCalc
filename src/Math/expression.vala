
namespace Pi.Math {
    public class Expression{
        string original_expression;
        private Term[] terms;
        private double values;
        private double power;
        public double coefficient;
        public bool has_a_function = false;
        private string _function;

        public Expression(string exp, double c = 1) {
            original_expression = exp;
            coefficient = 1;
            parse_expression();
        }

        public Expression.with_function(string exp, string f) {
            original_expression = exp;
            has_a_function = true;
            _function = f;
            parse_expression();
        }


        private void parse_expression()
        {
            string parsed = original_expression;
            Gee.ArrayList<Term> terms = new Gee.ArrayList<Term>();

            //y=x^2+2xy+x+3-sin(x);
            for (int i = 0; i < original_expression.char_count(); i++) {
                int ii = 0; // second index
                int depth = 0;
                unichar current = original_expression.get_char(i+ii);
                unichar sign = original_expression.get_char(i); // the sign
                string content; // the contents inside
                int back; // how far back have we gone for sign

                //lets grab the string content for our term
                while ((current != '+' || current != '-') && depth == 0)
                {
                    if(current == '(')
                    {
                     depth++; // if we went inside a new bracket, increase the depth
                    } else if (current == ')')
                    {
                     depth--; // if we hit a closed bracket, decrease the depth
                    }
                    ii++; // either way, we've progressed so increase the second index'
                    current = original_expression.get_char(i+ii);
                }

                //lets get a sign
                while (sign != '+' || sign != '-')
                {
                 back++; // increase amount to go back
                 sign = original_expression.get_char(i-back) // get the char before
                }
                if (original_expression.get_char(i) == '+' || original_expression.get_char(i) == '-')
                {
                  content = original_expression.substring(i+1, i+ii-1);
                }
                else {
                  content = original_expression.substring(i, i+ii-1);
                }

                i = i + ii;
                ii = 0;
            }
        }

        private bool hit_stop(int i, int ii)
        {
            return original_expression.get_char(i+ii) != '+' ||
                   original_expression.get_char(i+ii) != '-'||
                   i+ii > original_expression.char_count();
        }


///tobedeleted
        public void parse_terms()
        {
            string f = original_expression;
            int var_index = 0;
            for (int i = 0; i < f.char_count(); i++) {
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
                        //list.add(v);
                        }
                    catch (VariableError e) {
                        stdout.printf("variable error");
                    }
                }
            }
        }



        public double evaluate_when(unichar v, double value)
        {
            double result = 0;
            foreach (Term t in terms) {
                result = result + t.evaluate_when(v, value);
            }
            foreach (Expression expr in expressions) {
                result = result + expr.evaluate_when(v, value);
            }

            if (has_a_function) {
                result = Math.calculate_math_function(_function, result);
            }
            return result*coefficient;
        }

        public static bool is_numeric_expression(string content)
        {
            bool result = false; // its not by default
            /*
            find out if we have +, -, or spaces
            if we do, eliminate those, we should be left with
            only numbers and letters, try to parse it as a
            double, if possible, then we dont have an expression
            we have an operation
            */

            content.replace(" ", ""); // remove all spaces

            foreach (string s in Math.symbols) {
                content.replace(s, ""); // remove all math symbols
            }


            double v = double.parse(content);
            if (v == 0) {
                result = true;
            }
            return result;
        }

        public static bool is_expression(string content)
        {
            bool result = false; // its not by default
            /*
            find out if we have +, -, or spaces
            if we do, eliminate those, we should be left with
            only numbers and letters, try to parse it as a
            double, if possible, then we dont have an expression
            we have an operation
            */

            content.replace(" ", ""); // remove all spaces

            foreach (string s in Math.symbols) {
                content.replace(s, ""); // remove all math symbols
            }

            for (int i = 0;i < content.char_count(); i++) {
                if (content.get_char(i).to_string() in CharacterSet.a_2_z || content.get_char(i).to_string() in CharacterSet.A_2_Z) {
                 content.replace(content.get_char(i).to_string(), ""); // remove all letters
                }
            }

            double v = double.parse(content);
            if (v == 0) {
                result = true;
            }
            return result;
        }

    }
}
