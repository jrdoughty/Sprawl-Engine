package systems;

import echoes.System;
import components.*;
import slide.Slide;

class MoveToTargetPosition extends System
{
    @a public function queueTweenU(pos:Position, target:TargetPosition,u:Unit) 
    {
        var dlt = Math.abs(pos.x - target.x)+ Math.abs(pos.y - target.y);
        Slide.tween(pos)
            .to({x:target.x,y:target.y}, dlt/200)
            .ease(slide.easing.Quad.easeIn)
            .start();
            
    }
    @a public function queueTweenE(pos:Position, target:TargetPosition, e:Enemy) 
    {
        var dlt = Math.abs(pos.x - target.x)+ Math.abs(pos.y - target.y);
        Slide.tween(pos)
            .to({x:target.x,y:target.y}, dlt/50)
            .ease(slide.easing.Quad.easeInOut)
            .start();
            
    }
    @a public function queueTweenC(pos:Position, target:TargetPosition, e:Catcher) 
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