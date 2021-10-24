package components.core;

import kha.FastFloat;

abstract Angle(FastFloat) from FastFloat to FastFloat
{
    public inline function new(f:FastFloat = 0) this = f;
}