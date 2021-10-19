package systems;

import echoes.System;
import echoes.View;
import components.*;
class EnemyIdleMovement extends System 
{  
    var enemyView:View<Enemy, Position>;
    @u  function update() {
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
                    unit.add(t);
                }    
            }
        }
    }
}