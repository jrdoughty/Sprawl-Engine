package systems.core;

import kha.Image;
import echoes.System;
import echoes.View;
import components.*;
import kha.Color;
import  kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.FastFloat;
import kha.Framebuffer;
import kha.Assets;
import components.core.*;

class SpriteRender extends System
{
    var bufferCallback:Void->Framebuffer;
    var sprites:View<ImageComp,Bounds2D>;



    public function new()
    {
        bufferCallback = Project.bufferCallback;
    }

    
    public static function renderByEntity(g: Graphics, e:echoes.Entity): Void {
		var ic = e.get(ImageComp);
		var ac = e.get(AnimComp);
		var wh:Bounds2D = e.get(Bounds2D);
		var pos:Position = e.get(Position);
		var s:Scale = e.get(Scale);
		var vis:Visible = e.get(Visible);
		var angle:Angle = e.get(Angle);
        var x = pos.x;
        var y = pos.y;
        //Render at center is default unless the entity has a TopLeftRenderComp
        if(e.get(TopLeftRender) == null)
        {
            if(s == null)
            {
                x -= Math.round(wh.w/2);
                y -= Math.round(wh.h/2);
            }
            else
            {
                
                x -= Math.round(wh.w/2*s.x);
                y -= Math.round(wh.h/2*s.y);
            }
        }
		if (ic != null && vis != null && cast(vis, Bool) )
			{
			g.color = Color.White;
			if (angle != null && cast(angle,FastFloat) != 0) 
					g.pushTransformation(g.transformation.multmat(FastMatrix3.translation(pos.x , pos.y )).multmat(FastMatrix3.rotation(cast(angle,FastFloat))).multmat(FastMatrix3.translation(-pos.x , -pos.y )));
			if(ac != null)
                g.drawScaledSubImage(ic, Std.int(ac.indices[ac.index] * wh.w) % ic.width, 
                    Math.floor(ac.indices[ac.index] * wh.w / ic.width) * wh.h, 
                    wh.w, wh.h, 
                    x, y, 
                    wh.w * s.x, wh.h * s.y);
            else if (s == null) {
                g.drawImage(ic,x,y);
            }
            else
                g.drawScaledImage(ic, x, y, wh.w*s.x, wh.h*s.y);
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
    @d inline function sortByYPos() 
    {
        sprites.entities.sort(function(a,b){return Math.round(a.get(Position).y - b.get(Position).y);});
    }
    @d inline function draw() 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        
        sprites.entities.sort(function(a,b){return Math.round(a.get(Position).y - b.get(Position).y);});
        // micro optimizaion to not test each entity twice
        var h1 = sprites.entities.head;
        while (h1 != null) {
            var entity1 = h1.value;
            renderByEntity(buffer.g2, entity1);
            h1 = h1.next;
        }
    }
	
}