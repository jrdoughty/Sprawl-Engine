package systems;

import echoes.System;
import kha.Color;
import kha.Framebuffer;
import echo.shape.Circle;
import echo.Body;
using kha.graphics2.GraphicsExtension;

class EchoShapeRender extends System
{
    var bufferCallback:Void->Framebuffer;

    public function new(func:Void->Framebuffer)
    {
        bufferCallback = func;
    }

    
    @d function draw(c:Circle,b:Body) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.Yellow;
        buffer.g2.drawCircle(c.x+b.x,c.y+b.y,c.radius,2);
    }
	
}