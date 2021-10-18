package systems;

import echoes.System;
import components.*;
import echoes.View;

class EnemyUnitCollision extends System 
{
    var enemies:View<Enemy, Position, Scale>;
    var score:View<ScoreComp>;

    @u inline function checkOverlap(unit:Unit, pos:Position, wh:WHComp) {
        // micro optimizaion to not test each entity twice
        var h1 = enemies.entities.head;
        while (h1 != null) {

            var entity1 = h1.value;
            var posE = entity1.get(Position);
            
            if (Utils.AABBTestFromCenter(entity1.get(Position), entity1.get(WHComp), pos,wh)) 
            {
                score.entities.head.value.get(ScoreComp).score += 100;
                entity1.get(Position).y = -100;
                entity1.add(new Death());
            }
            

            h1 = h1.next;
        }
    }


    
}