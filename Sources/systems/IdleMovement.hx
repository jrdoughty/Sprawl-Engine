package systems;

import echoes.System;
import echoes.View;
import echoes.Entity;
import components.*;
import components.core.*;
import nape.shape.Circle;
class IdleMovement extends System 
{  
    var playerView:View<Player, Position>;
    var circleView:View<Circle>;

    
    @u  function updateU(unit:Entity,u:Unit, pos:Position) {
        if(unit.get(TargetPosition) != null && 
            Math.round(unit.get(TargetPosition).x) == Math.round(unit.get(Position).x) && 
            Math.round(unit.get(TargetPosition).y) == Math.round(unit.get(Position).y))
        {
            unit.remove(TargetPosition);
            var standardIdleFrames = 60;
            if(unit.get(Unit).framesUntil >0)
                true;
            else
                unit.get(Unit).framesUntil = standardIdleFrames;
            if(unit.get(AnimData) != null &&unit.get(AnimComp) != null && unit.get(AnimData).get('idle') != null)
            {
                if(unit.get(Unit).framesUntil <= standardIdleFrames)
                    unit.add(unit.get(AnimData).get('idle'));
                else
                    unit.add(unit.get(AnimData).get('dazed'));
            }
        }
        unit.get(Unit).framesUntil--; 
        if(unit.get(Unit).framesUntil <= 0 && unit.get(TargetPosition) == null )
        {                  
            var t = createPositionAround(playerView.entities.head.value.get(Position),64);   
            if(t.y > Main.PLAYAREAHEIGHT)
                t.y = Main.PLAYAREAHEIGHT;
            if(t.x < unit.get(Position).x && unit.get(Scale).x > 0 || t.x > unit.get(Position).x && unit.get(Scale).x < 0)
            {
                unit.get(Scale).x *= -1;
            }
            unit.add(t);
            if(unit.get(AnimData) != null &&unit.get(AnimComp) != null  && unit.get(AnimData).get('run') != null)
            {
                unit.add(unit.get(AnimData).get('run'));
            }
        }  
    }
    @u  function updateE(unit:Entity,enemy:Enemy, position:Position) {
        if(unit.get(Death)== null)
        {
            if(unit.get(TargetPosition) != null && 
                Math.round(unit.get(TargetPosition).x) == Math.round(unit.get(Position).x) && 
                Math.round(unit.get(TargetPosition).y) == Math.round(unit.get(Position).y))
            {
                unit.remove(TargetPosition);
                unit.get(Enemy).framesUntil = 45;
                if(unit.get(AnimData) != null &&unit.get(AnimComp) != null && unit.get(AnimData).get('idle') != null)
                {
                    unit.add(unit.get(AnimData).get('idle'));
                }
            }
            unit.get(Enemy).framesUntil--; 
            if(unit.get(Enemy).framesUntil <= 0 && unit.get(TargetPosition) == null )
            {               
                var t = createPositionAround(unit.get(Position),96);
                if(t.y > Main.PLAYAREAHEIGHT)
                    t.y = Main.PLAYAREAHEIGHT;
                if(t.x < unit.get(Position).x && unit.get(Scale).x > 0 || t.x > unit.get(Position).x && unit.get(Scale).x < 0)
                {
                    unit.get(Scale).x *= -1;
                }
                unit.add(t);
                if(unit.get(AnimData) != null &&unit.get(AnimComp) != null  && unit.get(AnimData).get('run') != null)
                {
                    unit.add(unit.get(AnimData).get('run'));
                }
            }    
        }
    }

    public function createPositionAround(pos:Position, range:Float):TargetPosition 
    {
        return cast(Utils.findRandomPointInCircle(pos,32), TargetPosition);
    }
    @u  function updateC(unit:Entity,c:Catcher, p:Position) {
        
        if(unit.get(TargetPosition) != null && 
            Math.round(unit.get(TargetPosition).x) == Math.round(unit.get(Position).x) && 
            Math.round(unit.get(TargetPosition).y) == Math.round(unit.get(Position).y))
        {
            unit.remove(TargetPosition);
            c.framesUntil = c.dFramesUntil;
            if(unit.get(AnimData) != null &&unit.get(AnimComp) != null && unit.get(AnimData).get('idle') != null)
            {
                unit.add(unit.get(AnimData).get('idle'));
            }
        }
        c.framesUntil--; 
        if(c.framesUntil <= 0 && unit.get(TargetPosition) == null )
        {       
            var t:TargetPosition = null; 
            var dist:Float = 200;
            for(i in circleView.entities)
            {
                if(i.get(Circle).body.position.y - i.get(Circle).radius > unit.get(Position).y - unit.get(Bounds2D).h/2 && 
                    Math.abs(unit.get(Position).x - i.get(Circle).body.position.x) < dist)
                {
                    dist = Math.abs(unit.get(Position).x - i.get(Circle).body.position.x);
                    t = new TargetPosition(i.get(Circle).body.position.x,Math.round(unit.get(Position).y));
                }
            }       
            if(t== null)
                t = new TargetPosition(Math.round(unit.get(Position).x + 64 - 128* Math.random()),Math.round(unit.get(Position).y));
            if(t.x<0)
                t.x = 0;
            else if(t.x>Main.WIDTH)
                t.x = Main.WIDTH;
            if(t.x < unit.get(Position).x && unit.get(Scale).x > 0 || t.x > unit.get(Position).x && unit.get(Scale).x < 0)
            {
                unit.get(Scale).x *= -1;
            }
            unit.add(t);
            if(unit.get(AnimData) != null &&unit.get(AnimComp) != null  && unit.get(AnimData).get('run') != null)
            {
                unit.add(unit.get(AnimData).get('run'));
            }
        }    
    }
}