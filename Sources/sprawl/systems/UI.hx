package sprawl.systems;

import kha.Color;
import components.*;
import sprawl.components.*;
import echoes.System;
import kha.Framebuffer;
import echoes.Entity;


class UI extends echoes.System
{
    var bufferCallback:Void->Framebuffer;
    
    public function new(bc:Void->Framebuffer)
    {
        bufferCallback = bc;
    }
    
    @u function updateAward(a:AwardFont, p:Position) 
    {
        p.y--;
        if(p.y < Main.PLAYAREAHEIGHT)
            p.y = -100;
    }
    
    @d function drawScore(s:ScoreComp) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.White;
        buffer.g2.font = AssetRepo.fonts.get("_8bitlim");
		buffer.g2.fontSize = 48;
		buffer.g2.drawString("Score "+s.score+"", 32, 32);
    }
    
    @d function drawTimeLeft(t:TimeData, s:ScoreComp) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        var timeLeft =Math.round((t.get('timer').endTime - t.get('timer').currentTime));
        buffer.g2.color = timeLeft>5?Color.White:Color.Red;
        buffer.g2.font = AssetRepo.fonts.get("_8bitlim");
		buffer.g2.fontSize = 48;
		buffer.g2.drawString("Time " + (timeLeft>=0?timeLeft:0), 496, 32);
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
        buffer.g2.font = AssetRepo.fonts.get("_8bitlim");
		buffer.g2.fontSize = 48;
		buffer.g2.drawString(a.value, p.x, p.y);
    }
    @d function drawButtonFont(b:ButtonComp, p:Position, wh:Bounds2D, s:Scale) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = Color.White;
        buffer.g2.font = AssetRepo.fonts.get("_8bitlim");
        buffer.g2.fontSize = Math.round(8*s.y);
        buffer.g2.drawString(b.tag, p.x - wh.w/2 - b.tag.length * s.y, p.y - wh.h/2 - buffer.g2.fontSize/2);//totally non-scientific way of centering the text
        
    }
    
    @d function drawText(t:TextComp, p:Position, s:Scale) 
    {
        var buffer = bufferCallback();
        if(buffer == null) return;
        buffer.g2.color = t.color;
        buffer.g2.font = AssetRepo.fonts.get(t.font);
        buffer.g2.fontSize = Math.round(8*s.y);
        buffer.g2.drawString(t.text, p.x - t.text.length * s.y, p.y - buffer.g2.fontSize/2);//totally non-scientific way of centering the text
        
    }
}