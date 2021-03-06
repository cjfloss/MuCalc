
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
	public bool is_numeric = false;

        //TODO Parsing, Coefficients...
        //
        public Term(string term, unichar si = '+') {
            original_term = term;
            sign = si;
                      //if our term is just a number
            if(Math.is_valid_number(term))
            {
		is_numeric = true;
		stdout.printf("--new numeric term \"" + original_term + "\" created \n");
                vars = new Variable[1];
                //assume power is one
                vars[0] = new Variable.with_number('+', double.parse(term), "1"); // assume its positive
            }
            else{
		stdout.printf("--new term \"" + original_term + "\" created \n");
                coefficient = Math.extract_num_coefficient(original_term);
                string_term = original_term.replace(coefficient.to_string(), "");
                parse_term();
            }

        }

        public double evaluate_when(unichar vari, double value)
        {
            double result = 0;
	    if(is_numeric) // if our term is just a number
	     {
		return vars[0].evaluate_when(vari, value);
	     }
            foreach (Variable v in vars) {
                result += result + v.evaluate_when(vari, value);
		stdout.printf("\x1b[36mVariable \"\x1b[33m" + v.to_string() + "\x1b[36m\" returned the value \"\x1b[33m" + v.evaluate_when(vari, value).to_string() + "\x1b[36m\" \x1b[0m\n");
            }

            foreach (Expression expr in exprs) {
                result += expr.evaluate_when(vari, value);
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
            Gee.ArrayList<Expression> expressions = new Gee.ArrayList<Expression>();
	    char[] array = string_term.to_utf8();
            if(string_term.contains("("))
            {
                //deal with powers
		for (int i = 0; i < array.length; i++)// for each char in our arrray
		{
		    int ii = 3;
	 	    int depth = 1;
		    string power_string = "";
		 if(array[i+1] == '^' && array[i+2] == '(') // if we found the power symbol with a bracket
		  {
		    while (array[i+ii]!=')' && depth != 0) // go on until we hit a close mracket
			{
			  if(array[i+ii] == '(')
			   {
			    depth++;
			   }
			  if(array[i+ii] == ')')
			   {
			    depth--;
                }
			  power_string = power_string + array[i+ii].to_string();
			  ii++;
			}
			variables.add(new Variable.with_letter('+', array[i], power_string)); // new var with power
		  }
		 else
		  {
			// its a normal variable with no power
			variables.add(new Variable.with_letter('+', array[i], "1")); //assume power is one
		  }
		  i = i+ii+1;
		  ii = 3;
		  depth = 1;
		  power_string = "";
		}
            }else
            {
                //we just have variables
                foreach (char ch in string_term.to_utf8())
                {
                // ASSUME POWER IS ONE
                    variables.add(new Variable.with_letter('+', ch, "1"));
                }
            }
           vars = variables.to_array();
        } // method ender
    }
}
