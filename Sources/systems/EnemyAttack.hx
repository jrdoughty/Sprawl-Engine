package systems;

import echoes.System;
import echoes.View;
import components.*;
import echo.Echo;
import echo.shape.Circle;
import echo.Body;
import echo.World;
import echo.shape.Rect;
class EnemyAttack extends System 
{  
    var enemyView:View<Enemy, Position>;
    var once = false;

    var world:echo.World;

    public  function new(w:World){
        world = w;
    }

    @u  function update() {
        for(enemy in enemyView.entities)
        {
            if(enemy.get(Enemy).framesUntil > 28 && !once)
            {
                once = !once;
                var c = Circle.get(0,0,5,5);
                var b = new Body();

                b.shapes.push(c);
                b.gravity_scale = 1;
                b.mass = 1;
                b.x = enemy.get(Position).x;
                b.y = enemy.get(Position).y;
                world.add(b);
                var attack = new echoes.Entity().add(c).add(b);

                
                var r:Rect = Rect.get(0,0,40,10);
                //c = Circle.get(0,0,5,5);
                var nb = new Body();
                nb.shapes.push(c);
                //nb.gravity_scale = 1;
                nb.mass = 0;
                nb.x = enemy.get(Position).x - 10;
                nb.y = enemy.get(Position).y + 80;
                world.add(nb);
                var floor = new echoes.Entity().add(r).add(nb);

                
    // Create a Body with a Circle Collider and add it to the World
    var a = world.make({
        elasticity: 0.2,
        x:48,
        shape: {
          type: CIRCLE,
          radius: 16,
        }
      });
      var aTest = new echoes.Entity().add(a).add(cast(a.shapes[0],Circle));
  
      // Create a Body with a Rectangle collider and add it to the World
      // This Body will have a Mass of zero, rendering it as unmovable
      // This is useful for things like platforms or walls.
      var d = world.make({
        mass: 0, // Setting this to zero makes the body unmovable by forces and collisions
        x:48,
        y: 48, // Set the object's Y position below the Circle, so that gravity makes them collide
        elasticity: 0.2,
        shape: {
          type: RECT,
          width: 10,
          height: 10
        }
      });
      var dTest = new echoes.Entity().add(d).add(cast(d.shapes[0], Rect));
  
      // Create a listener and attach it to the World.
      // This listener will react to collisions between Body "a" and Body "b", based on the configuration options passed in
      world.listen(a, b, {
        separate: true, // Setting this to true will cause the Bodies to separate on Collision. This defaults to true
        enter: (a, d, c) -> trace("Collision Entered"), // This callback is called on the first frame that a collision starts
        stay: (a, d, c) -> trace("Collision Stayed"), // This callback is called on frames when the two Bodies are continuing to collide
        exit: (a, d) -> trace("Collision Exited"), // This callback is called when a collision between the two Bodies ends
      });
                
            world.listen(attack.get(Body), floor.get(Body), {
                separate: false, // Setting this to true will cause the Bodies to separate on Collision. This defaults to true
                //enter: (a, b,c) -> {a.mass = 0;b.mass = 0;} // This callback is called on the first frame that a collision starts
                //stay: (a, b, c) -> trace("Collision Stayed"), // This callback is called on frames when the two Bodies are continuing to collide
                //exit: (a, b) -> trace("Collision Exited"), // This callback is called when a collision between the two Bodies ends
            });
            }   
        }
    }
}