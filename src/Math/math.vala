
namespace Pi.Math {


    /**
    * @return [String array of mathematical symbols]
    */
    public const string[] symbols = {"(", ")", "[", "]", "<", ">", "/", ".", "+", "-", "^", "%", "^", "*", "e", "E", "sin", "SIN", "Sin"};


    /**
    * @return [String array of mathematical function symbols]
    */
    public const string[] functions = {"sin", "SIN", "Sin"};


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

        //get rid of signs if we have them
        if (n.get_char(0) == '+' || n.get_char(0) == '-') {
            nn = n.substring(1, n.char_count());
        }
        else
        {
         nn=n;
        }


        try {
            double.parse(n); // try to parse it
            return true; // we parsed it, its a number
        } catch (Error e) {

        }
        return false; // didnt parse it, its not a number
    }


    /**
    * @param [string s] [The string to extract from]
    * @param [bool remove] [Remove the coefficient from the passed string]
    * @return [The coefficient of the passed string]
    */
    public double extract_coefficient(out string s, bool remove)
    {
        //get coefficients if they exist
        double c = 1;
        int i = 0; // index
        while(Math.is_valid_number(s.substring(0,i))) // while we have numbers keep going on
        {
          i++; // increase the index
        }

        if (Math.is_valid_number(s.get_char(0).to_string())) { //if first char isnt number
            c = 1; // our coefficient is one
        }
        else {
            c = double.parse(s.substring(0,i-1)); //i-1 so we dont grab last char, it is not part of the coefficient
        }
        if(remove) // the user asked to remove the coefficient
        {
            string returned = s.substring(i, s.char_count()); //remove the coefficient
            s = returned; // assign the new string to the passed paramater
        }
        return c; // return the c value
    }

}
