namespace Pi.Math {


    /**
    * @return [String array of mathematical symbols]
    */
    public const string[] symbols = {"(", ")", "[", "]", "<", ">", "/", ".", "+", "-", "^", "%", "^", "*", "e", "E", "sin", "SIN", "Sin"};


    /**
    * @return [String array of mathematical function symbols]
    */
    public const string[] functions = {"sin", "SIN", "Sin"};


	public string replace_first(string text, string search, string replace)
	{
	  int pos = text.index_of(search);
	  if (pos < 0)
	  {
	    return text;
	  }
	  return text.substring(0, pos) + replace + text.substring(pos + search.char_count());
	}


    /**
    * @param [string f] [The function to be preformed (ex. sin)]
    * @param [string v] [The value passed to preform the function on]
    * @return [The result of the passed function]
    */
    public double calculate_math_function(string f, double v)
    {
        if (f == "sin" || f == "SIN" || f == "Sin") {
            return GLib.Math.sin(v); // we have a sign function
        }
        // add for each math function

        //all failed
        return -1;
    }


    /**
    * @param [string n] [The string to be checked]
    * @param [string f] [The function found in it]
    * @return [True if math functions exist, false otherwise]
    */
    public bool has_functions(string n, out string f)
    {
        for (int i = 0; i < functions.length; i++) { // for every item in functions array
            if (n.contains(functions[i])) { // if the string contains the specific item
                f = functions[i]; // assign the item function found to the paramter f
                return true; // we found a function
            }
        }
        return false; // we didnt find anything
    }


    /**
    * @param [string n] [The string to be checked]
    * @return [True if the string is a number, false otherwise]
    */
    public bool is_valid_number(string n)
    {
        string nn;//new string

        //get rid of signs and points and spaces if we have them
        if (n.get_char(0) == '+' || n.get_char(0) == '-' ||  n.get_char(0) == '.' ||  n.get_char(0) == ' ') {
            nn = n.substring(1, n.char_count());
        }
        else
        {
         nn=n;
        }
        //check if we have digits
        foreach (char ch in nn.to_utf8())
        {
            if(GLib.CharacterSet.DIGITS.contains(ch.to_string()))
            {

            }
            else
            {
                return false; //found a non number, this is not a number
            }
        }

        return true; // if it got here, its a number
    }


    /**
    * @param [string s] [The string to extract from]
    * @param [bool remove] [Remove the coefficient from the passed string]
    * @return [The coefficient of the passed string]
    */
    public double extract_num_coefficient(string s)
    {
        
	stdout.printf("\x1b[35m" + "extracting a coefficient from string \"\x1b[33m" + s + "\x1b[35m\" \n");
       	
	if(Expression.is_numeric_expression(s))
	{
	 return 1;
	}

	 if(is_valid_number(s))
        {
          stdout.printf("--extracted \"\x1b[33m1\x1b[35m\" \x1b[0m\n ");
	  return 1; // if we are passed a number, the coefficient will be one, dont parse anything
        }
	//get coefficients if they exist
        double c = 1.0;
        int i = 0; // index

        string coef; // coef (used if we have an expression)
        int fi; // first index (used if we have an expression)
        //check if we are parsing an expression or term
        stdout.printf("--checking parenthesis \n");
        if (s != null && s.has_suffix(")") && !s.contains("^(")) // if our string ends with a parenthesis
        {
           stdout.printf("--found paranthesis, we are checking an expression \n");
           fi = s.index_of_char('(', 0); // find when we first open paranthesis
           coef = s.substring(0, fi); // get the coefficients
           if(s.substring(0, fi).length > 0) // if coef exist
           {
             c = double.parse(coef);
           }
         }
         else{
            stdout.printf("--keep looking for numbers. \n");
            while(Math.is_valid_number(s.substring(0,i))) // while we have numbers keep going on
            {
              i++; // increase the index
            }

            if (!Math.is_valid_number(s.get_char(0).to_string())) { //if first char isnt number
                stdout.printf("--if we didn't find any coefficients, default to 1.' \n");
                c = 1; // our coefficient is one
            }
            else {
                c = double.parse(s.substring(0,i-1)); //i-1 so we dont grab last char, it is not part of the coefficient
                if (i-1 == 0)
                {
                    c = 1; // deal with one digit variables or numbers
                }
		if (s.has_prefix(c.to_string() + "^"))
		{
		   c = 1; // its raised to a power so its variable not coef
		}
            }
            }
            stdout.printf("--extracted \"\x1b[33m" + c.to_string() + "\x1b[35m\" \x1b[0m\n ");
            return c; // return c
         }

}
