
namespace Pi.Math {
    public class Expression{
        string original_expression; // The string_expression before parsing
        string string_expression; // The string_expression after parsing
        private Term[] terms; // The terms inside this expression
        private Expression powerexp; // The power of this expression (used when power is an expression)
        private string power; // power string (used if power is a number)
        public double coefficient; // coefficients of this expression
        public bool has_a_function = false; // the expression has a function
        private string _function; // the function we have
        private bool power_is_an_expression; // our power is an expression

        //TODO PARSING POWERS
        public Expression(string exp) {
            original_expression = exp;
            string_expression = original_expression;
            stdout.printf("--new expression \"" + string_expression + "\" created \n");
            coefficient = Math.extract_num_coefficient(string_expression);
	    if (coefficient!=1)
            {
		string_expression = Math.replace_first(string_expression,coefficient.to_string(), "");
	    }
            if (string_expression.get_char(0) == '(')
            {
                string_expression = string_expression.substring(1, string_expression.last_index_of_char(')') - 1);
            }
            stdout.printf("-- expression_string after extraction \"" + string_expression + "\" \n");
            parse_expression(); //parse it
        }

       /* public Expression.with_function(string exp, string f) {
            string_expression = exp;
            has_a_function = true;
            _function = f;
            parse_expression();
        } */


        private void parse_expression()
        {
            string se = this.string_expression;
            Gee.ArrayList<Term> t = new Gee.ArrayList<Term>();
            Gee.ArrayList<string> list = new Gee.ArrayList<string>();
            stdout.printf("Parsing expression \x1b[34m\"" + se + "\" \x1b[0m \n");
                string[] p = string_expression.split("+");
                for (int i=0; i<p.length; i++)
                {
                    int depth = 0;
                    int ii = 0;
                    if (p[i].contains("("))
                    {
                    // paranthesis logic
                    }
                    list.add(p[i+ii]);
                }
                foreach (string content in list)
                {
                  stdout.printf("adding new term + \"" + content + "\" \n");
                  t.add(new Term(content));
                }
            terms = t.to_array();
        }

        private bool hit_stop(int i, int ii)
        {
            return string_expression.get_char(i+ii) != '+' ||
                   string_expression.get_char(i+ii) != '-'||
                   i+ii > string_expression.char_count();
        }

        public double evaluate_when(unichar v, double val)
        {
        if (val.to_string().char_count() > 5)
        {
            stdout.printf("\x1b[32m" + "evaluating expression \"\x1b[33m" +
                                     original_expression + "\x1b[32m\"for when \"\x1b[33m" +
                                     v.to_string() + "\"\x1b[32m is \"\x1b[33m" + val.to_string() +
                                      "\x1b[32m\" \n\x1b[0m");
                                      }
            double result = 0;
            foreach (Term t in terms) {
                result += t.evaluate_when(v, val);
            stdout.printf("\x1b[32m" + "added term \"\x1b[33m" +
                                     t.original_term + "\x1b[32m\"to result \"\x1b[33m" +
                                     result.to_string() + "\x1b[32m\" \n\x1b[0m");
            }

            if (has_a_function) {
                result = Math.calculate_math_function(_function, result);
            }

            if (power != "")
            {
                if (power_is_an_expression)
                {
                    result = GLib.Math.pow(result, powerexp.evaluate_when(v, val));
                }
                else if (power != null)
                {
                   result = GLib.Math.pow(result, double.parse(power));
                }
            }
            stdout.printf("\x1b[32m" + "--answer is \"\x1b[33m" +
                                     (result*coefficient).to_string() +
                                      "\x1b[32m\" \n\x1b[0m");
            return result*coefficient;
        }

        public static bool is_numeric_expression(string parse)
        {
	    string content = parse;
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
               content = content.replace(s, ""); // remove all math symbols
            }
	    stdout.printf("checking numeric expression \""+ content + "\" .............. is "+ Math.is_valid_number(content).to_string() + "\n");
            return Math.is_valid_number(content);
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
                if (content.get_char(i).to_string() in CharacterSet.a_2_z ||
                        content.get_char(i).to_string() in CharacterSet.A_2_Z){
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
