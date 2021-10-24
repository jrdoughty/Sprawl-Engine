package components.core;

@:forward
abstract Visible(Bool) from Bool to Bool
{
    public inline function new(b:Bool) this = b;
}
