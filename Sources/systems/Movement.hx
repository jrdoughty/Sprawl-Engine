package systems;

import echoes.System;
import components.Position;
import components.Velocity;

class Movement extends  System
{
    @u inline function move(dt:Float, pos:Position, vel:Velocity) {
        var dx = vel.x * dt;
        var dy = vel.y * dt;

        pos.x += dx;
        pos.y += dy;

        
    }

}