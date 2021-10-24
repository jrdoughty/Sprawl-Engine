package systems;

import echoes.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import components.core.*;
import haxe.ds.StringMap;

class CreditMenu extends System
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
            new ImageComp(images.button),
            new AnimData(new StringMap()),
            new Scale(10,5),
            new WHComp(48,16),
            new Visible(true),
            new ButtonComp('menu'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, 85),
            new Scale(10,18),
            new Visible(true),
            new TextComp("John Doughty",Assets.fonts._8bitlim,kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, 85),
            new Scale(10,17.5),
            new Visible(true),
            new TextComp("John Doughty",Assets.fonts._8bitlim,kha.Color.Yellow)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, 215),
            new Scale(10,15.5),
            new Visible(true),
            new TextComp("Art and Code",Assets.fonts._8bitlim,kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, 215),
            new Scale(10,15),
            new Visible(true),
            new TextComp("Art and Code",Assets.fonts._8bitlim,kha.Color.Yellow)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, 590),
            new Scale(10,10),
            new Visible(true),
            new TextComp("Special Thanks",Assets.fonts._8bitlim,kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, 590),
            new Scale(10,9.5),
            new Visible(true),
            new TextComp("Special Thanks",Assets.fonts._8bitlim,kha.Color.Yellow)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, 660),
            new Scale(10,9.75),
            new Visible(true),
            new TextComp("Ben Immel and Nick Cash",Assets.fonts._8bitlim,kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, 660),
            new Scale(10,9.5),
            new Visible(true),
            new TextComp("Ben Immel and Nick Cash",Assets.fonts._8bitlim,kha.Color.Yellow)
        );
    }

    @u public function mouseBtnUpdate (m:MouseComp, b:ButtonComp, p:Position, wh:WHComp, s:Scale)
    {
        var mPos = new Position(m.x,m.y);
        if(m.mousePressed[0] && Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            //trace(b.tag+' down');
        }
        else if(m.mouseUp[0] && Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            //trace(b.tag);
            Project.activeState = b.tag;
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