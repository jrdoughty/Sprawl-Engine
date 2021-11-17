package components.core;

import kha.math.FastMatrix3;
import components.core.*;

class Camera {
    public var transform:FastMatrix3;

    public function new() {
        transform = FastMatrix3.identity();    
    }
}