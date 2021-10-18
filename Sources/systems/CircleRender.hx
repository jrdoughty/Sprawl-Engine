package systems;

import echoes.System;
import kha.Color;
import kha.Framebuffer;
import echo.shape.Circle;
using kha.graphics2.GraphicsExtension;

class CircleRender extends System
{
    var bufferCallback:Void->Framebuffer;

    public function new(func:Void->Framebuffer)
    {
        bufferCallback = func;
    }

    
    @d function draw(c:Circle) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.Yellow;
        buffer.g2.drawCircle(c.x,c.y,c.radius,2);
    }
	
}