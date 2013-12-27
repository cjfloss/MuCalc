
namespace Pi.Math {
    public class Point : Object {
        public double x;
        public double y;

        public Point(double x, double y) {
            this.x = x;
            this.y = y;
        }

        public Point.rectangular(double x, double y) {
            this(x, y);
        }

        public Point.polar(double radius, double angle) {
            this.rectangular(radius * GLib.Math.cos(angle), radius * GLib.Math.sin(angle));
        }
    }
}