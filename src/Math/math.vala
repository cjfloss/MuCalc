
namespace Pi.Math {

    public const string[] symbols = {"(", ")", "[", "]", "<", ">", "/", ".", "+", "-", "^", "%", "^", "*", "e", "E", "sin", "SIN", "Sin"};
    public const string[] functions = {"sin", "SIN", "Sin"};

    public double calculate_math_function(string f, double v)
    {
        if (f == "sin" || f == "SIN" || f == "Sin") {
            return GLib.Math.sin(v);
        }
        // add for each math function

        //all failed
        return -1;
    }    

    public bool is_valid_number(string n)
    {
        if (n.get_char(0) = '+' || n.get_char(0) = '-') {
            n = n.substring(1, n.char_count());
        }
        bool result = false;
        try {
            double.parse(n);
            result = true;
        } catch (Error e) {
            
        }
        return result;
    }

    public bool has_functions(string n, out string f)
    {
        for (int i = 0; i < functions.length; i++) {
            if (n.contains(functions[i])) {
                f = functions[i];
                return true;
            }
        }
        return false;
    }

}