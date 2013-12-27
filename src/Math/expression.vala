
namespace Pi.Math {
    public class Expression{
        string original_expression;
        private Term[] terms;
        private double values;
        private Expression[] expressions;
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
            Gee.ArrayList<Expression> expressions = new Gee.ArrayList<Expression>();

            //y=x^2+2xy+x+3-sin(x);
            for (int i = 0; i < original_expression.char_count(); i++) {
                int ii = 0; // second index
                if (original_expression.get_char(i) != '+' || original_expression.get_char(i) != '-') {
                    while (original_expression.get_char(i+ii) != '-'|| i+ii > original_expression.char_count()) {
                     ii++;   
                    }
                }
                string content = original_expression.substring(i+1, i+ii-1);
                if (content.contains("(")) {
                    // to do check sub expressions or terms 
                }
                else if (content.char_count() > 1 && 1 == 1) { // change 1 == 1, its place holder
                    //check if it has a coefficient
                    // add term
                }else{
                    terms.add(new Term(content, original_expression.get_char(i)));
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