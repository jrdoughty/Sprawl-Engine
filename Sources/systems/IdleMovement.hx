package systems;

import echoes.System;
import echoes.View;
import components.*;
class IdleMovement extends System 
{  
    var unitView:View<Unit, Position>;
    var enemyView:View<Enemy, Position>;
    var catcherView:View<Catcher, Position>;
    @u  function updateU(player:Player, pos:Position) {
        for(unit in unitView.entities)
        {
            if(unit.get(TargetPosition) != null && 
                Math.round(unit.get(TargetPosition).x) == Math.round(unit.get(Position).x) && 
                Math.round(unit.get(TargetPosition).y) == Math.round(unit.get(Position).y))
            {
                unit.remove(TargetPosition);
                unit.get(Unit).framesUntil = 30;
            }
            unit.get(Unit).framesUntil--; 
            if(unit.get(Unit).framesUntil <= 0 && unit.get(TargetPosition) == null )
            {               
                var t:TargetPosition = cast(Utils.findRandomPointInCircle(pos,100), TargetPosition);
                if(t.y > Main.PLAYAREAHEIGHT)
                    t.y = Main.PLAYAREAHEIGHT;
                unit.add(t);
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
                }
                unit.get(Enemy).framesUntil--; 
                if(unit.get(Enemy).framesUntil <= 0 && unit.get(TargetPosition) == null )
                {               
                    var t:TargetPosition = cast(Utils.findRandomPointInCircle(unit.get(Position),32), TargetPosition);
                    
                    if(t.y > Main.PLAYAREAHEIGHT)
                        t.y = Main.PLAYAREAHEIGHT;
                    unit.add(t);
                }    
            }
        }
    }
    @u  function updateC() {
        for(unit in catcherView.entities)
        {
            if(unit.get(TargetPosition) != null && 
                Math.round(unit.get(TargetPosition).x) == Math.round(unit.get(Position).x) && 
                Math.round(unit.get(TargetPosition).y) == Math.round(unit.get(Position).y))
            {
                unit.remove(TargetPosition);
                unit.get(Catcher).framesUntil = 45;
            }
            unit.get(Catcher).framesUntil--; 
            if(unit.get(Catcher).framesUntil <= 0 && unit.get(TargetPosition) == null )
            {               
                var t:TargetPosition = new TargetPosition(Math.round(unit.get(Position).x + 64 - 128* Math.random()),Math.round(unit.get(Position).y));
                if(t.x<0)
                    t.x = 0;
                else if(t.x>Main.WIDTH)
                    t.x = Main.WIDTH;
                unit.add(t);
            }    
        
        }
    }
}