package components.core;

import components.core.Vec2;

@:forward
abstract Scale(Vec2) from Vec2 to Vec2
{
    public inline function new(x = 1.0, y = 1.0) this = new Vec2(x, y);
}
