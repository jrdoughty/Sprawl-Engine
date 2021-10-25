package components.core;

import components.core.Vec2;

@:forward
abstract RenderOffset2D(Vec2) from Vec2 to Vec2 {

    public inline function new(x = .0, y = .0) this = new Vec2(x, y);

}
