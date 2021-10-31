package components.core;

import kha.FastFloat;

class Angle implements hxbit.Serializable 
{
    @:s public var value:FastFloat;
    public inline function new(f:FastFloat = 0) value = f;
}