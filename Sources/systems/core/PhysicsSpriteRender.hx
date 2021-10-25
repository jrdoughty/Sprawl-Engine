package systems.core;

import kha.Image;
import nape.phys.BodyType;
import echoes.System;
import kha.Color;
import kha.Framebuffer;
import nape.shape.*;
import components.*;
import kha.math.Vector2;
import nape.geom.Vec2;
import kha.Color;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.FastFloat;
import kha.Framebuffer;
import kha.Assets;
import echoes.Entity;
import components.core.*;


class PhysicsSpriteRender extends System
{
    var bufferCallback:Void->Framebuffer;
 
    public function new()
    {
        bufferCallback = Project.bufferCallback;
    }

    @u public function updateRotationOfCoin(c:Circle, a:Angle)
    {
        a = cast(c.body.rotation, Angle);   
    }

    
    @d inline function draw(e:Entity,i:ImageComp,c:Circle) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
            renderByCircleEntity(buffer.g2, e);
        
    }

    public static function renderByCircleEntity(g: Graphics, e:echoes.Entity): Void {
		var ic = e.get(ImageComp);
		var ac = e.get(AnimComp);
		var wh:Bounds2D = new Bounds2D(e.get(Circle).radius*2,e.get(Circle).radius*2);
		var pos:Position = new Position(e.get(Circle).body.position.x,e.get(Circle).body.position.y);
		var s:Scale = new Scale();
		var vis:Visible = new Visible(true);
		var angle:Angle = e.get(Angle);
        var x = pos.x;
        var y = pos.y;
        var xOffset = 0.5;// Assumed we render from the center of the sprite by default
        var yOffset = 0.5;
        var renderOffset = e.get(RenderOffset2D);
        var xScale = 1.0;// Assume a sprite scale of 1:1 by default
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
			g.drawScaledSubImage(ic, Std.int(ac.indices[ac.index] * wh.w) % ic.width, 
            Math.floor(ac.indices[ac.index] * wh.w / ic.width) * wh.h, 
            wh.w, wh.h, 
            x, y, 
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