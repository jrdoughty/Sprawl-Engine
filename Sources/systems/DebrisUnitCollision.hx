package systems;

import echoes.System;
import components.*;
import echoes.View;
import nape.phys.Material;
import nape.phys.BodyType;
import nape.phys.Body;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.geom.Vec2;
import echoes.Entity;
import kha.Assets;
import kha.audio1.Audio;

class DebrisUnitCollision extends System 
{
    var debriss:View<Debris, Position, Scale>;

    @u inline function checkOverlap(unit:Unit, pos:Position, wh:WHComp) {
        // micro optimizaion to not test each entity twice
        var h1 = debriss.entities.head;
        while (h1 != null) {

            var debris = h1.value;
            var posE = debris.get(Position);
            
            if (Utils.AABBTestFromCenter(debris.get(Position), debris.get(WHComp), pos,wh)) 
            {
                //score.entities.head.value.get(ScoreComp).score += 100;

                for(i in 0...(Math.round(Math.random())))
                {
                    var c = new Circle(4);
                    var speedY = -1 * (Math.random() * .75 + .15)-4;
                    var speedX = 2-4*Math.random();
                    c.body = new Body(BodyType.DYNAMIC);
                    c.body.position.x = debris.get(Position).x;
                    c.body.position.y = debris.get(Position).y-4;
                    c.body.shapes.at(0).material = new Material(0,1,2,.5,.001);
                    c.body.applyImpulse(new Vec2(speedX, speedY));
                    c.body.applyAngularImpulse(5);
                    new Entity().add(c,
                        new ImageComp(Assets.images.coin),
                        AnimComp.createAnimDataRange(0,0,Math.round(100)),
                        new Angle(0));
                    Audio.play(Assets.sounds.debris);
                }
                debris.remove(Debris); 
                unit.framesUntil += 30;
                /*
                var vs:Array<Vec2> = Polygon.box(50,10);
                var p:Polygon = new Polygon(vs);
                p.body = new Body(BodyType.STATIC);
                p.body.position.x = enemy.get(Position).x-20;
                p.body.position.y = enemy.get(Position).y+20;
                var floor = new Entity().add(p);
                */
            }
            

            h1 = h1.next;
        }
    }


    
}