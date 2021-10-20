package systems;

import echoes.System;
import nape.space.Space;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.geom.Vec2;
class PhysicsSystem extends System
{
    var space:Space;
    public function new() 
    {
        space = new Space(new Vec2(0,350));
    }

    @a public function addCircle(c:Circle) 
    {
        space.bodies.add(c.body);
    }

    @a public function addPoly(p:Polygon) 
    {
        space.bodies.add(p.body);
    }
    @u public function update() 
    {
		space.step(1/60);
    }
}