package sprawl.systems;

import echoes.System;
import nape.shape.*;
import echoes.Entity;
import sprawl.components.*;


class PhysicsStateTransformer extends System
{
    
    public function new()
    {
    }

    @u public function updateRotationOfCoin(circle:Circle, rotation:Rotation)
    {    
        rotation.rotation = circle.body.rotation;
    }   
    
    @u public function updateBounds(circle:Circle, bounds2D:Bounds2D)
    {
        var diameter = circle.radius*2;
            
        bounds2D.w = diameter;
        bounds2D.h = diameter;
    }

    @u public function updatePosition(circle:Circle, position:Position)
    {
        // trace('updating position');
        position.x = circle.body.position.x;
        position.y = circle.body.position.y;
    }
}