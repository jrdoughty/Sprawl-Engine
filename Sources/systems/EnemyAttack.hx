package systems;

import echoes.System;
import echoes.View;
import components.*;
import echo.Echo;
import echo.shape.Circle;
class EnemyAttack extends System 
{  
    var enemyView:View<Enemy, Position>;
    @u  function update() {
        for(enemy in enemyView.entities)
        {
            if(enemy.get(Enemy).framesUntil > 28)
            {
                var attack = new echoes.Entity().add(Circle.get(enemy.get(Position).x,enemy.get(Position).y,5,0));
            }   
        }
    }
}