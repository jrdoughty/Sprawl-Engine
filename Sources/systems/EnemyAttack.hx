package systems;

import nape.geom.Vec2;
import nape.shape.Circle;
import echoes.Entity;
import echoes.System;
import echoes.View;
import components.*;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.phys.Body;
import nape.shape.Polygon;
class EnemyAttack extends System 
{  
    var enemyView:View<Enemy, Position>;
    var once = false;


    public  function new(){
    }

    @u  function update() {
        for(enemy in enemyView.entities)
        {
            if(enemy.get(Enemy).framesUntil > 3 )
            {
                once = !once;
            }
        }
    }
}