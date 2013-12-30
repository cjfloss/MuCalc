
namespace Pi.Math {
    public class Term : Object {
        // a term is a group of variables multiplied together, no +, -, or /
        public double constant;
        public unichar sign ;
        public Term[] terms;
        public Variable[] vars;
        public Expression[] exprs;
        public double coefficient;
        public string original_term;
        public string string_term;
        private string _function;
        public bool has_a_function = false;


        //TODO Parsing, Coefficients...
        //
        public Term(string term, unichar si = '+') {
            original_term = term;
            sign = si;
            string_term = "";
            //if our term is just a number
            if(Math.is_valid_number(term))
            {

            }
            else{
                coefficient = Math.extract_coefficient(out string_term, true);
                parse_term();
            }

        }


        public double evaluate_when(unichar vari, double value)
        {
            double result = 0;
            foreach (Variable v in vars) {
                if (vari == v.letter) {

                }
                result = result + v.evaluate_when(value);
            }

            foreach (Expression expr in exprs) {
                result = result + expr.evaluate_when(vari, value);
            }

            if (has_a_function) {
                result = Math.calculate_math_function(_function, result);
            }
            return result*coefficient;
        }

        public static bool is_term(string content)
        {
            if (content.contains("+ ") || content.contains("- ") || content.contains(" ")) {
                return false;
            }
            else{
                return true;
            }
        }

        private void parse_term()
        {
            char si;
            Gee.ArrayList<Variable> variables = new Gee.ArrayList<Variable>();
            Gee.ArrayList<Term> terms = new Gee.ArrayList<Term>();
            Gee.ArrayList<Expression> expressions = new Gee.ArrayList<Expression>();
            for (int i = 0; i < original_term.char_count(); i++) {
                if (original_term.get_char(i) == '(') {
                    int iii = 1;
                    int ii = 0;
                    string contents = "";
                    while (original_term.get_char(ii) != ')' && iii != 0) {

                        if (original_term.get_char(ii) == ')')
                        {
                            iii = iii - 1;
                        }
                        else if (original_term.get_char(ii) == '(') {
                            iii = iii + 1;
                        }
                        ii++;
                    }
                    contents = original_term.substring(i,ii);
                    if (Expression.is_expression(contents)) {
                        expressions.add(new Expression(contents));
                    }
                    else {
                        terms.add(new Term(contents));
                    }
                }

            }

        } // method ender
    }
}
