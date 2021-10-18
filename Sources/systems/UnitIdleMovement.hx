package systems;

import echoes.System;
import echoes.View;
import components.*;
class UnitIdleMovement extends System 
{  
    var unitView:View<Unit, Position>;
    @u  function update(player:Player, pos:Position) {
        for(unit in unitView.entities)
        {
            if(unit.get(TargetPosition) != null && 
                Math.round(unit.get(TargetPosition).x) == Math.round(unit.get(Position).x) && 
                Math.round(unit.get(TargetPosition).y) == Math.round(unit.get(Position).y))
                {
                    unit.remove(TargetPosition);
                    unit.get(Unit).framesUntil = 45;
                }
            unit.get(Unit).framesUntil--; 
            if(unit.get(Unit).framesUntil <= 0 && unit.get(TargetPosition) == null )
            {               
                var t:TargetPosition = cast(Utils.findRandomPointInCircle(pos,100), TargetPosition);
                unit.add(t);
            }   
        }
    }
}