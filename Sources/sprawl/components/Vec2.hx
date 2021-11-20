package sprawl.components;

class Vec2  implements hxbit.Serializable 
{
    @:s public var x:Float = 0;
    @:s public var y:Float = 0;
    public function new(x = .0, y = .0)
    {
        this.x = x;
        this.y = y;   
    }
}
