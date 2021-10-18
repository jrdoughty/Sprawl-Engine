package systems;

import echoes.System;
import components.*;
import slide.Slide;

class MoveToTargetPosition extends System
{
    @a public function queueTween(pos:Position, target:TargetPosition) 
    {
        var dlt = Math.abs(pos.x - target.x)+ Math.abs(pos.y - target.y);
        Slide.tween(pos)
            .to({x:target.x,y:target.y}, dlt/50)
            .ease(slide.easing.Quad.easeInOut)
            .start();
            
    }
    @r public function removeTarget(pos:Position, target:TargetPosition) 
    {
    }
}