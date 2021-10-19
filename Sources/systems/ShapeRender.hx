package systems;

import nape.phys.BodyType;
import echoes.System;
import kha.Color;
import kha.Framebuffer;
import nape.shape.*;
import kha.math.Vector2;
import nape.geom.Vec2;

using kha.graphics2.GraphicsExtension;

class ShapeRender extends System
{
    var bufferCallback:Void->Framebuffer;

    public function new(func:Void->Framebuffer)
    {
        bufferCallback = func;
    }

    
    @d function drawCircle(c:Circle) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        if(c.body.type == BodyType.DYNAMIC)
            buffer.g2.color = Color.Yellow;
        else if(c.body.type == BodyType.STATIC)
            buffer.g2.color = Color.Orange;
        else 
            buffer.g2.color = Color.Red;
        buffer.g2.drawCircle(c.body.position.x,c.body.position.y,c.radius,2);
    }
     
    @d function drawPoly(p:Polygon) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.Red;
        var verts:Array<Vector2> = [];
        for(i in p.localVerts)
        {
            verts.push(new Vector2(i.x,i.y));   
        }
        buffer.g2.drawPolygon(p.body.position.x,p.body.position.y, verts);
        //trace(b.x + "r.x  "+b.y +"r.y");
    }
    

}