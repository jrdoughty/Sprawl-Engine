package systems.core;

import kha.Image;
import nape.phys.BodyType;
import echoes.System;
import kha.Color;
import kha.Framebuffer;
import nape.shape.*;
import components.*;
import kha.math.Vector2;
import nape.geom.Vec2;
import kha.Color;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.FastFloat;
import kha.Framebuffer;
import kha.Assets;
import echoes.Entity;
import components.core.*;


class PhysicsStateTransformer extends System
{
    
    public function new()
    {
    }

    @u public function updateRotationOfCoin(circle:Circle, angle:Angle)
    {    
        angle.value = cast(circle.body.rotation, FastFloat);
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