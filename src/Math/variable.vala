using Gtk;
namespace Pi.Math {

    public class Variable : GLib.Object{
        private string _power;
        private Expression _expression_power;
        private char _sign;
        private unichar _letter;
        private double _number;
        public bool is_a_number = false;
        public bool power_is_an_expression = false;


        public Variable.with_letter(char s, unichar l, string p) throws VariableError
        {
            stdout.printf("new variable \"" + l.to_string() + "\" created with power of \"" + p + "\" \n");
	    if(Math.is_valid_number(p))
 	    {
	     _power = p;
	    }
	    else
	    {
	     power_is_an_expression = true;
	     _expression_power = new Expression(p);
	    }

            if (can_be_var(l))
            {
                letter = l;
            }
            else {
                throw new VariableError.LETTER_ERROR("The letter has to be part of the alphabet");
            }
            if (s.to_string() in "+ -")
            {
                sign = s;
            }
            else {
                throw new VariableError.SIGN_ERROR("The sign is either + or -");
            }
        }



        public Variable.with_number(char s, double l, string p) throws VariableError
        {
            stdout.printf("new variable \"" + l.to_string() + "\" created with power of \"" + p + "\" \n");
                number = l;
                is_a_number = true;

            if (s.to_string() in "+ -")
            {
                sign = s;
            }
            else {
                throw new VariableError.SIGN_ERROR("The sign is either + or -");
            }
             if(Math.is_valid_number(p))
 	    {
	     _power = p;
	    }
	    else
	    {
	     power_is_an_expression = true;
	     _expression_power = new Expression(p);
	    }


        }

        public string power {

            get { return _power; }
            set { _power = value; }
            default = "1";
        }

        public char sign {

            get { return _sign; }
            set { _sign = value; }
            default = '+';

        }

        public unichar letter {

            get { return _letter; }
            set { _letter = value; }
            default = 'x';
        }

        public double number {

            get { return _number; }
            set { _number = value; }
            default = 0;
        }

        public static bool can_be_var(unichar value)
        {
            if(value == 'e' || value == 'E')
            {
                return false;
            }

            if (is_numeric(value.to_string()))
            {
                return true;
            }

            if ("/*^\\()<>[]{}".contains(value.to_string())) {
                return false;
            }

            return true;
        }

        public static bool is_numeric(string value)
        {
            try {
                double d = double.parse(value);
                stdout.printf(d.to_string() + " is a number\n");
                return true; // if its a number, we can
            } catch (Error e) {
                return false;
            }

        }

        public void switch_sign () {
            if (sign == '-') {
                sign = '+';
            }
            else {
                sign = '-';
            }
        }

        public bool is_negative
        {
            get{
            if (this.sign == '-') {
                return true;
            }else if (this == null) {
                return false;
            }

            return false;
        }
        }

        public double evaluate_when(unichar vari, double val)
        {
            double pwr = 0;
            double result = 0;
            if(power_is_an_expression)
            {
                var exp = new Expression(power);
                pwr = exp.evaluate_when(vari, val);
            }
            else{
                pwr = double.parse(power);
            }
            if (is_a_number)
            {
                result = GLib.Math.pow(number ,pwr);
            }
            else if (vari == letter){
                result = GLib.Math.pow(val ,pwr);
            }
            else{
            
            }
            return result;
        }

        public string to_string()
        {
            string result = "";
            if (is_a_number) {
            result = sign.to_string() + number.to_string() + "^(" + power + ")";
            }
            result = sign.to_string() + letter.to_string() + "^(" + power + ")";
            return (result);
        }


    }

    public errordomain VariableError {
        SIGN_ERROR,
        LETTER_ERROR
    }

}
