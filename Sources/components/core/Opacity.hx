package components.core;

import kha.FastFloat;

class Visibility
{
    @:s public var opacity:FastFloat = 1;
    @:s public var visible:Bool = true;

    public function new(opacity:FastFloat = 1,visible:Bool = true)
    {
        this.opacity = opacity;
        this.visible = visible;
    }
}
