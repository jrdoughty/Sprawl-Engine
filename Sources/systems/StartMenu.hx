package systems;

import echoes.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import haxe.ds.StringMap;

class StartMenu extends System
{
    public function new() {
        var speed = 5;
        var images = Assets.images;
        
        new Entity().add(//Background
            new Position(0, 0),
            AnimComp.createAnimDataRange(0,0,Math.round(100)),
            new ImageComp(images.menubackground),
            new Scale(Main.WIDTH/images.menubackground.width,Main.HEIGHT/images.menubackground.height),
            new WHComp(Main.WIDTH,Main.HEIGHT),
            new WHComp(Main.WIDTH,Main.HEIGHT),
            new Visible(true),
            new TopLeftRender(true));
        new Entity().add(
            new Position(Main.WIDTH /2 , Main.HEIGHT/2),
            new Velocity(0,0),
            new ImageComp(images.button),
            new AnimData(new StringMap()),
            new Scale(10,5),
            new WHComp(48,16),
            new Visible(true),
            new ButtonComp('play'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
    }

    @u public function mouseBtnUpdate (m:MouseComp, b:ButtonComp, p:Position, wh:WHComp, s:Scale)
    {
        if(m.mousePressed[0] && Utils.pointInAABBTestWithScaleCentered(new Position(m.x,m.y),p,wh,s))
        {
            trace(b.tag+' down');
        }
        else if(m.mouseUp[0] && Utils.pointInAABBTestWithScaleCentered(new Position(m.x,m.y),p,wh,s))
        {
            Project.activeState = 'play';
        }
        else if(Utils.pointInAABBTestWithScaleCentered(new Position(m.x,m.y),p,wh,s))
        {
            //over            
        }
        else 
        {
            //out 
        }
    }
/*
	public function new(?btns:Array<Button>)
	{
		Mouse.get().notify(down, up, move, scroll);
	}

	public function down(mButton:Int, x:Int, y:Int)
	{
		for(i in Button.buttons)
		{
			if(i.background != null && i.background.x <= x &&i.background.x + i.background.width >= x && i.background.y <= y &&i.background.y + i.background.height >= y)
			{
				i.click(mButton, x, y);
			}
		}
	}
	public function up(mButton:Int, x:Int, y:Int)
	{
	}	
	public function move(x:Int,y:Int,cx:Int,cy:Int)
	{

	}
	public function scroll(scroll:Int)
	{

	}
    */

}