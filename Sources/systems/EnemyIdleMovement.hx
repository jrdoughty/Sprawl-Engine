package systems;

import echoes.System;
import echoes.View;
import components.*;
class EnemyIdleMovement extends System 
{  
    @u  function update(unit:Enitity,e:Enemy, p:Position) {
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