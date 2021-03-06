package sprawl;
import components.*;
import sprawl.components.*;
class Utils {
    public static inline function getDistanceByPosition(pos1:Vec2,  pos2:Vec2):Float
    {        
        return Math.sqrt((pos1.x-pos2.x)*(pos1.x-pos2.x)+(pos1.y-pos2.y)*(pos1.y-pos2.y));
    }
    /**
     * Find the distance between two points.
     * @param	x1		The first x-position.
     * @param	y1		The first y-position.
     * @param	x2		The second x-position.
     * @param	y2		The second y-position.
     * @return	The distance.
     */
    public static function distance(x1:Float, y1:Float, x2:Float = 0, y2:Float = 0):Float
    {
        return Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    }
    public static inline function pointInAABBTest(pos1:Position,  pos2:Position, wh2:Bounds2D) {
        return pos1.x < pos2.x+wh2.w &&
            pos1.x > pos2.x &&
            pos1.y < pos2.y+wh2.h &&
            pos1.y > pos2.y;
    }
    public static inline function pointInAABBTestWithScale(pos1:Vec2,  pos2:Vec2, wh2:Bounds2D,s:Scale) {
        return pos1.x < pos2.x+wh2.w * s.x &&
            pos1.x > pos2.x &&
            pos1.y < pos2.y+wh2.h * s.y &&
            pos1.y > pos2.y;
    }
    public static inline function pointInAABBTestWithScaleCentered(pos1:Vec2,  pos2:Vec2, wh2:Bounds2D,s:Scale) {
        return pos1.x < pos2.x + wh2.w/2 * s.x &&
            pos1.x > pos2.x - wh2.w/2 * s.x  &&
            pos1.y < pos2.y + wh2.h/2 * s.y &&
            pos1.y > pos2.y - wh2.h/2 * s.y;
    }
    public static inline function AABBTest(pos1:Vec2, wh1:Bounds2D, pos2:Vec2, wh2:Bounds2D) {
        return pos1.x < pos2.x+wh2.w &&
            pos1.x + wh1.w > pos2.x &&
            pos1.y < pos2.y+wh2.h &&
            pos1.y + wh1.h > pos2.y;
    }
    public static inline function AABBTestFromCenter(pos1:Vec2, wh1:Bounds2D, pos2:Vec2, wh2:Bounds2D) {
        return pos1.x - wh1.w/2 < pos2.x + wh2.w/2 &&
            pos1.x + wh1.w/2 > pos2.x  - wh2.w/2&&
            pos1.y - wh1.h/2 < pos2.y + wh2.h/2 &&
            pos1.y + wh1.h/2 > pos2.y - wh2.h/2;
    }
    public static inline function AABBTestWithScale(pos1:Vec2, wh1:Bounds2D, pos2:Vec2, wh2:Bounds2D) {
        return pos1.x < pos2.x+wh2.w &&
            pos1.x + wh1.w > pos2.x &&
            pos1.y < pos2.y+wh2.h &&
            pos1.y + wh1.h > pos2.y;
    }
    public static inline function AABBTestFromCenterWithScale(pos1:Vec2, wh1:Bounds2D, pos2:Vec2, wh2:Bounds2D) {
        return pos1.x - wh1.w/2 < pos2.x + wh2.w/2 &&
            pos1.x + wh1.w/2 > pos2.x  - wh2.w/2&&
            pos1.y - wh1.h/2 < pos2.y + wh2.h/2 &&
            pos1.y + wh1.h/2 > pos2.y - wh2.h/2;
    }
    //http://jeffreythompson.org/collision-detection/circle-rect.php
    /**
     * This will provide a Bool for two centered entities, based on Position and Width of each
     * @param recPos 
     * @param recWH 
     * @param cirPos 
     * @param r 
     */
    public static inline function CenteredRectCircleOverlapTest(recPos:Vec2, recWH:Bounds2D, cirPos:Vec2, r:Float) {
        
        var modifiedPos = new Position(recPos.x - recWH.w/2,recPos.y - recWH.h/2);

        return RectCircleOverlapTest(modifiedPos, recWH, cirPos,r);
    }
    public static inline function RectCircleOverlapTest(recPos:Vec2, recWH:Bounds2D, cirPos:Vec2, r:Float) {
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

    //
    /**
     * Returns a random Position within a circle
     * https://programming.guide/random-point-within-circle.html#:~:text=Generating%20a%20random%20point%20within%20a%20circle%20%28uniformly%29,a%20uniformly%20random%20number%20between%200%20and%201.
     * @param	centerPoint	The center of the circle, uses Echo System's Position.
     * @param	radius		The radius of the circle.
     * @return	The randomized Position in the circle.
     */
     public static inline function findRandomPointInCircle(centerPoint:Vec2, radius:Float) {
        var a = Math.random() * 2 * Math.PI;
        var r = radius * Math.sqrt(Math.random());
        // If you need it in Cartesian coordinates
        var x = r * Math.cos(a);
        var y = r * Math.sin(a);
        return new Position(x+centerPoint.x,y+centerPoint.y);
    }
}