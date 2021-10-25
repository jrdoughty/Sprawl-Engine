package components.core;
import kha.math.Vector2;
@:forward
abstract Vec2(Vector2)  {
    public function new(x = .0, y = .0) this = new Vector2(x, y);
}
