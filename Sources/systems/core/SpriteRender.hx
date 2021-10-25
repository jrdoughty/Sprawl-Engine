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

    @d inline function draw() 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        
        sprites.entities.sort(function(a,b){
            var aPosition = a.get(Position);
            var bPosition = b.get(Position);
    
            return Math.round(aPosition.y - bPosition.y);
        });
        // micro optimizaion to not test each entity twice
        var h1 = sprites.entities.head;
        while (h1 != null) {
            var entity1 = h1.value;
            renderByEntity(buffer.g2, entity1);
            h1 = h1.next;
        }
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
        var xOffset = 0.5; // Assumed we render from the center of the sprite by default
        var yOffset = 0.5;
        var renderOffset = e.get(RenderOffset2D);
        var xScale = 1.0; // Assume a sprite scale of 1:1 by default
        var yScale = 1.0;


        if(renderOffset != null) // If we have a render offset, we'll grab the offsets from that instead
        { 
            xOffset = renderOffset.x;
            yOffset = renderOffset.y;
        }
        
        if (s != null) // If we have a scale component, check the components scale instead of using our default
        {
            xScale = s.x;    
            yScale = s.y;    
        }

        // Calculate the final X/Y,based on our render offset and scale
        x -= Math.round(wh.w * xOffset * xScale); 
        y -= Math.round(wh.h * yOffset * yScale);

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
                    wh.w * xScale, wh.h * yScale);
            else if (s == null) {
                g.drawImage(ic,x,y);
            }
            else
                g.drawScaledImage(ic, x, y, wh.w*xScale, wh.h*yScale);
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