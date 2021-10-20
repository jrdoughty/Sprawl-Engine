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
    }
    
    @d function drawS(s:ScoreComp) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.White;
        buffer.g2.font = Assets.fonts.OpenSans;
		buffer.g2.fontSize = 48;
		buffer.g2.drawString(s.score+"", 32, 32);
    }
    
    @d function drawAward(a:AwardFont, p:Position) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        a.r += 1;
        a.g += 3;
        a.b += 7;
        a.b %= 256;
        a.r %= 256;
        a.g %= 256;
        buffer.g2.color = Color.fromBytes(a.r,a.g,a.b);
        buffer.g2.font = Assets.fonts.OpenSans;
		buffer.g2.fontSize = 48;
		buffer.g2.drawString(a.value, p.x, p.y);
    }
    
    @u function updateAward(a:AwardFont, p:Position) 
    {
        p.y--;
        if(p.y < Main.PLAYAREAHEIGHT)
            p.y = -100;
    }
}