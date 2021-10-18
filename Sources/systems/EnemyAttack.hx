package systems;

import echoes.System;
import echoes.View;
import components.*;
class EnemyAttack extends System 
{  
    var enemyView:View<Enemy, Position>;
    var once = false;


    public  function new(){
    }

    @u  function update() {
        for(enemy in enemyView.entities)
        {
            if(enemy.get(Enemy).framesUntil > 28 )
            {
                once = !once;
                
            }
        }
    }
}