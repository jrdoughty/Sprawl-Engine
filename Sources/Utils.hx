package;
import components.*;
class Utils {
    public static inline function pointInAABBTest(pos1:Position,  pos2:Position, wh2:WHComp) {
        return pos1.x < pos2.x+wh2.w &&
            pos1.x > pos2.x &&
            pos1.y < pos2.y+wh2.h &&
            pos1.y > pos2.y;
    }
    public static inline function pointInAABBTestWithScale(pos1:Position,  pos2:Position, wh2:WHComp,s:Scale) {
        return pos1.x < pos2.x+wh2.w * s.x &&
            pos1.x > pos2.x &&
            pos1.y < pos2.y+wh2.h * s.y &&
            pos1.y > pos2.y;
    }
    public static inline function pointInAABBTestWithScaleCentered(pos1:Position,  pos2:Position, wh2:WHComp,s:Scale) {
        return pos1.x < pos2.x + wh2.w/2 * s.x &&
            pos1.x > pos2.x - wh2.w/2 * s.x  &&
            pos1.y < pos2.y + wh2.h/2 * s.y &&
            pos1.y > pos2.y - wh2.h/2 * s.y;
    }
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
    //http://jeffreythompson.org/collision-detection/circle-rect.php
    //Centered needs fixed
    public static inline function CenteredRectCircleOverlapTest(recPos:Position, recWH:WHComp, cirPos:Position, r:Float) {
        
        var modifiedPos = new Position(recPos.x - recWH.w/2,recPos.y - recWH.h/2);

        return RectCircleOverlapTest(modifiedPos, recWH, cirPos,r);
    }
    public static inline function RectCircleOverlapTest(recPos:Position, recWH:WHComp, cirPos:Position, r:Float) {
        var testX:Float = cirPos.x;
        var testY:Float = cirPos.y;

        if (cirPos.x < recPos.x) testX = recPos.x;        // left edge
        else if (cirPos.x > recPos.x + recWH.w) testX = recPos.x + recWH.w;      // right edge

        if (cirPos.y < recPos.y) testY = recPos.y;        // top edge
        else if (cirPos.y > recPos.y + recWH.h) testY = recPos.y + recWH.h;     // bottom edge
        
        // get distance from closest edges
        var distX = cirPos.x-testX;
        var distY = cirPos.y-testY;
        var distance = Math.sqrt( (distX*distX) + (distY*distY) );

        // if the distance is less than the radius, collision!
        if (distance <= r) {
            return true;
        }
        return false;
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