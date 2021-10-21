package systems;

import kha.Color;
import components.*;
import echoes.System;
import kha.Framebuffer;
import kha.Assets;


class UI extends echoes.System
{
    var bufferCallback:Void->Framebuffer;

    
    public function new()
    {
        bufferCallback = Project.bufferCallback;
    }
    
    @d function drawScore(s:ScoreComp) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.White;
        buffer.g2.font = Assets.fonts._8bitlim;
		buffer.g2.fontSize = 48;
		buffer.g2.drawString(s.score+"", 32, 32);
    }
    
    @d function drawTimeLeft(t:TimeComp, s:ScoreComp) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.White;
        buffer.g2.font = Assets.fonts._8bitlim;
		buffer.g2.fontSize = 48;
		buffer.g2.drawString(Math.round((t.get('timer').endTime - t.get('timer').currentTime))+"", 96, 32);
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
        buffer.g2.font = Assets.fonts._8bitlim;
		buffer.g2.fontSize = 48;
		buffer.g2.drawString(a.value, p.x, p.y);
    }
    
    @u function updateAward(a:AwardFont, p:Position) 
    {
        p.y--;
        if(p.y < Main.PLAYAREAHEIGHT)
            p.y = -100;
    }
    
    @d function drawButtonFont(b:ButtonComp, p:Position, wh:WHComp, s:Scale) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.White;
        buffer.g2.font = Assets.fonts._8bitlim;
		buffer.g2.fontSize = Math.round(8*s.y);
		buffer.g2.drawString(b.tag, p.x - wh.w/2 - b.tag.length * s.y, p.y - wh.h/2 - buffer.g2.fontSize/2);//totally non-scientific way of centering the text
        
    }
}