using Gtk;
namespace Pi.Math {

    public class Variable : GLib.Object{
        private string _power;
        private Expression _expression_power;
        private Term _term_power;
        private char _sign;
        private unichar _letter;
        private double _number;
        public double coefficient; 
        public bool is_a_number = false;
        public bool power_is_an_expression = false;
        public bool power_is_a_term = false;


        public Variable.with_letter(char s, unichar l, string p, double c = 1) throws VariableError
        {
            coefficient = c;
            if (Expression.is_expression(p)) {
                power_is_an_expression = true;
                _expression_power = new Expression(p);
            }
            else if (Term.is_term(p)) {
                power_is_a_term = true;
                _term_power = new Term(p);
            }
            else{
                power = p;
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



        public Variable.with_number(char s, double l, string p, double c = 1) throws VariableError
        {
                number = l;
                coefficient = c;
                is_a_number = true;

            if (s.to_string() in "+ -")
            {
                sign = s;
            }
            else {
                throw new VariableError.SIGN_ERROR("The sign is either + or -");
            }
            power = p;
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

        public double evaluate_when(double value)
        {
            double result;
            double pwr;
            if (power_is_a_term) {
                if (is_a_number) {
                    pwr = _term_power.evaluate_when('x', value);                    
                }
                else
                {
                    pwr = _term_power.evaluate_when(letter, value);
                }
            }
            else if (power_is_an_expression) {
                if (is_a_number) {
                    pwr = _expression_power.evaluate_when('x', value);                    
                }
                else
                {
                    pwr = _expression_power.evaluate_when(letter, value);
                }                
            }
            else
            {
                pwr = double.parse(power);
            }
            
            if (is_a_number) {
                result = GLib.Math.pow(number, pwr);
                if (is_negative) {
                    result = 0 - result;
                }
                    return result*coefficient;                
            }
            else {
                result = GLib.Math.pow(value, pwr);
                if (is_negative) {
                    result = 0 - result;
                    return result*coefficient;
                }    
            return result*coefficient;                            
            }
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
