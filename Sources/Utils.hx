package;
import components.*;
class Utils {
    public static inline function AABBTest(pos1:Position, wh1:WHComp, pos2:Position, wh2:WHComp) {
        return pos1.x < pos2.x+wh2.w &&
            pos1.x + wh1.w > pos2.x &&
            pos1.y < pos2.y+wh2.h &&
            pos1.y + wh1.h > pos2.y;
    }
    public static inline function AABBTestFromCenter(pos1:Position, wh1:WHComp, pos2:Position, wh2:WHComp) {
        return pos1.x - wh1.w/2 < pos2.x + wh2.w/2 &&
            pos1.x + wh1.w/2 > pos2.x  - wh2.w/2&&
            pos1.y - wh1.h/2 < pos2.y + wh2.h/2 &&
            pos1.y + wh1.h/2 > pos2.y - wh2.h/2;
    }

    //https://programming.guide/random-point-within-circle.html#:~:text=Generating%20a%20random%20point%20within%20a%20circle%20%28uniformly%29,a%20uniformly%20random%20number%20between%200%20and%201.
    public static inline function findRandomPointInCircle(centerPoint:Position, radius:Float) {
        
        var a = Math.random() * 2 * Math.PI;
        var r = radius * Math.sqrt(Math.random());
        // If you need it in Cartesian coordinates
        var x = r * Math.cos(a);
        var y = r * Math.sin(a);
        return new Position(x+centerPoint.x,y+centerPoint.y);
    }
}