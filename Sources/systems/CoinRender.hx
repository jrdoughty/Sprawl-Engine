package systems;

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


class CoinRender extends System
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
    public static function renderByCircleEntity(g: Graphics, e:echoes.Entity): Void {
		var ic = e.get(ImageComp);
		var ac = e.get(AnimComp);
		var wh:WHComp = new WHComp(e.get(Circle).radius*2,e.get(Circle).radius*2);
		var pos:Position = new Position(e.get(Circle).body.position.x,e.get(Circle).body.position.y);
		var s:Scale = new Scale();
		var vis:Visible = new Visible(true);
		var angle:Angle = e.get(Angle);
        var x = pos.x;
        var y = pos.y;
        //Render at center is default unless the entity has a TopLeftRenderComp
        if(e.get(TopLeftRender) == null)
        {
            x -= Math.round(wh.w/2);
            y -= Math.round(wh.h/2);
        }
		if (ic.value != null && vis != null && cast(vis, Bool) )
			{
			g.color = Color.White;
			if (angle != null && cast(angle,FastFloat) != 0) 
					g.pushTransformation(g.transformation.multmat(FastMatrix3.translation(pos.x , pos.y )).multmat(FastMatrix3.rotation(cast(angle,FastFloat))).multmat(FastMatrix3.translation(-pos.x , -pos.y )));
			g.drawScaledSubImage(ic.value, Std.int(ac.indices[ac.index] * wh.w) % ic.value.width, 
            Math.floor(ac.indices[ac.index] * wh.w / ic.value.width) * wh.h, 
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
    @d inline function draw(e:Entity,i:ImageComp,c:Circle) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
            renderByCircleEntity(buffer.g2, e);
        
    }
     
    

}