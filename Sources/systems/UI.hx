package systems;

import kha.Color;
import components.*;
import echoes.System;
import kha.Framebuffer;
import kha.Assets;


class UI extends echoes.System
{
    var bufferCallback:Void->Framebuffer;

    public function new(func:Void->Framebuffer)
    {
        bufferCallback = func;
        //System.notifyOnRender(updateMovedSprite);
    }
    
    @d function draw(s:ScoreComp) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.White;
        buffer.g2.font = Assets.fonts.OpenSans;
		buffer.g2.fontSize = 48;
		buffer.g2.drawString(s.score+"", 32, 32);
    }
}