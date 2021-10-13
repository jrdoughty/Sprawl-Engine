package systems;

import echoes.System;
import echoes.View;
import components.*;
import kha.Color;
import  kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.FastFloat;
import kha.Framebuffer;

class Render extends System
{
    var bufferCallback:Void->Framebuffer;
    var sprites:View<ImageComp>;


    @d function draw(player:Player, pos:Position) {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.begin(true,Color.Black);
        // micro optimizaion to not test each entity twice
        var h1 = sprites.entities.head;
        while (h1 != null) {

            var entity1 = h1.value;
            renderByEntity(buffer.g2, entity1);
            h1 = h1.next;
        }
        buffer.g2.end();
    }
    public function new(func:Void->Framebuffer)
    {
        bufferCallback = func;
		//System.notifyOnRender(updateMovedSprite);
    }

    /*
    @ad inline function onAddPosSprite(pos:Position) 
    {
        //tiles[Std.int(pos.y)][Std.int(pos.x)].appendChild(spr); 
    }
    @rm inline function onRemovePosSprite(pos:Position) 
    {
        //spr.remove();
    }
*/
    
    public static function renderByEntity(g: Graphics, e:echoes.Entity): Void {
		var ic = e.get(ImageComp);
		var ac = e.get(AnimComp);
		var wh:WH = e.get(WH);
		var pos:Position = e.get(Position);
		var s:Scale = e.get(Scale);
		var vis:Visible = e.get(Visible);
		var angle:Angle = e.get(Angle);
		if (ic.value != null && vis != null && cast(vis, Bool) )
			{
			g.color = Color.White;
			if (angle != null && cast(angle,FastFloat) != 0) 
					g.pushTransformation(g.transformation.multmat(FastMatrix3.translation(pos.x , pos.y )).multmat(FastMatrix3.rotation(cast(angle,FastFloat))).multmat(FastMatrix3.translation(-pos.x , -pos.y )));
			g.drawScaledSubImage(ic.value, Std.int(ac.indices[ac.index] * wh.w) % ic.value.width, 
            Math.floor(ac.indices[ac.index] * wh.w / ic.value.width) * wh.h, 
            wh.w, wh.h, 
            Math.round(pos.x), Math.round(pos.y), 
            wh.w * s.x, wh.h * s.y);
			if (angle != null && cast(angle,FastFloat) != 0) 
				g.popTransformation();
        }
		#if debug_collisions
			g.color = Color.fromBytes(255, 0, 0);
			g.drawRect(x - collider.x * scaleX, y - collider.y * scaleY, width, height);
			g.color = Color.fromBytes(0, 255, 0);
			g.drawRect(tempcollider.x, tempcollider.y, tempcollider.width, tempcollider.height);
		#end
	}
	
}