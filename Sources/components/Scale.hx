package components;

@:forward
abstract Scale(Vec2) {

    public inline function new(x = 1.0, y = 1.0) this = new Vec2(x, y);

}
