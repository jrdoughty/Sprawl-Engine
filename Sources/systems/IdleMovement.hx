package systems;

import echoes.System;
import echoes.View;
import components.*;
import nape.shape.Circle;
class IdleMovement extends System 
{  
    var unitView:View<Unit, Position>;
    var enemyView:View<Enemy, Position>;
    var catcherView:View<Catcher, Position>;
    var buildingView:View<Building, Position, WHComp>;
    var circleView:View<Circle>;

    
    @u  function updateU(player:Player, pos:Position) {
        for(unit in unitView.entities)
        {
            if(unit.get(TargetPosition) != null && 
                Math.round(unit.get(TargetPosition).x) == Math.round(unit.get(Position).x) && 
                Math.round(unit.get(TargetPosition).y) == Math.round(unit.get(Position).y))
            {
                unit.remove(TargetPosition);
                unit.get(Unit).framesUntil = 30;
                if(unit.get(AnimData) != null &&unit.get(AnimComp) != null && unit.get(AnimData).get('idle') != null)
                {
                    unit.add(unit.get(AnimData).get('idle'));
                }
            }
            unit.get(Unit).framesUntil--; 
            if(unit.get(Unit).framesUntil <= 0 && unit.get(TargetPosition) == null )
            {                      
                var t = createSafePositionAround(pos,64);
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
    @u  function updateE() {
        for(unit in enemyView.entities)
        {
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
                    var t = createSafePositionAround(unit.get(Position),32);
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
    }

    public function createPositionAround(pos:Position, range:Float):TargetPosition 
    {
        return cast(Utils.findRandomPointInCircle(pos,32), TargetPosition);
    }

    public function createSafePositionAround(pos:Position, range:Float):TargetPosition 
    {
        var t:TargetPosition = null;
        while(t == null)
        {
            var temp =  cast(Utils.findRandomPointInCircle(pos,range), TargetPosition);
            var safe = true;
            for(i in buildingView.entities)
            {
                if(temp.x > i.get(Position).x - i.get(WHComp).w/2 &&
                    temp.x < i.get(Position).x + i.get(WHComp).w/2 &&
                    temp.y > i.get(Position).y - i.get(WHComp).h/2 &&
                    temp.y < i.get(Position).y + i.get(WHComp).h/2)
                    safe = false;
                    break;
            }
            if(safe)
                t= temp;
        }
        return t;

    }
    @u  function updateC() {
        for(unit in catcherView.entities)
        {
            if(unit.get(TargetPosition) != null && 
                Math.round(unit.get(TargetPosition).x) == Math.round(unit.get(Position).x) && 
                Math.round(unit.get(TargetPosition).y) == Math.round(unit.get(Position).y))
            {
                unit.remove(TargetPosition);
                unit.get(Catcher).framesUntil = unit.get(Catcher).dFramesUntil;
                if(unit.get(AnimData) != null &&unit.get(AnimComp) != null && unit.get(AnimData).get('idle') != null)
                {
                    unit.add(unit.get(AnimData).get('idle'));
                }
            }
            unit.get(Catcher).framesUntil--; 
            if(unit.get(Catcher).framesUntil <= 0 && unit.get(TargetPosition) == null )
            {       
                var t:TargetPosition = null; 
                var dist:Float = 200;
                for(i in circleView.entities)
                {
                    if(i.get(Circle).body.position.y - i.get(Circle).radius > unit.get(Position).y - unit.get(WHComp).h/2 && 
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
}