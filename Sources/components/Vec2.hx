package components;

class Vec2 implements hxbit.Serializable {

    @:s public var x:Float;
    @:s public var y:Float;

    public function new(x = .0, y = .0) 
    {
        this.x = x;
        this.y = y;
    }

}
