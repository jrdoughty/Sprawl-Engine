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
            new ImageComp(images.menubackground),
            new Scale(Main.WIDTH/images.menubackground.width,Main.HEIGHT/images.menubackground.height),
            new WHComp(images.menubackground.width,images.menubackground.height),
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
        new Entity().add(
            new Position(Main.WIDTH /2, Main.HEIGHT/2 + 96),
            new Velocity(0,0),
            new ImageComp(images.button),
            new AnimData(new StringMap()),
            new Scale(10,5),
            new WHComp(48,16),
            new Visible(true),
            new ButtonComp('credits'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
    }

    @u public function mouseBtnUpdate (m:MouseComp, b:ButtonComp, p:Position, wh:WHComp, s:Scale)
    {
        var mPos = new Position(m.x,m.y);
        if(m.mousePressed[0] && Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            trace(b.tag+' down');
        }
        else if(m.mouseUp[0] && Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            Project.activeState = 'play';
        }
        else if(Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            //over            
        }
        else 
        {
            //out 
        }
    }


}