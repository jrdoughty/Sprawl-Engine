package components.core;


class Angle implements hxbit.Serializable 
{
    @:s public var value:Float = 0;
    public inline function new(f:Float = 0) value = f;
}