package components.core;

@:forward
abstract TopLeftRender(Bool) from Bool to Bool {

    public inline function new(b:Bool) this = b;

}
