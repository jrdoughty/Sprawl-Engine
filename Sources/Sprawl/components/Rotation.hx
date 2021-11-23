package sprawl.components;


class Rotation implements hxbit.Serializable {
    @:s public var value:Float = 0;

    public inline function new(?initialRotation:Float = 0) value = initialRotation;
}