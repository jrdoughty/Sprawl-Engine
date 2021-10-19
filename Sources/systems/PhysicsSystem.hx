package systems;

import echoes.System;
import nape.space.Space;
import nape.shape.Circle;
import nape.shape.Polygon;
class PhysicsSystem extends System
{
    var space:Space;
    public function new(s:Space) {
        space = s;
    }

    @a public function addCircle(c:Circle) 
    {
        space.bodies.add(c.body);
    }

    @a public function addPoly(p:Polygon) 
    {
        space.bodies.add(p.body);
    }
}