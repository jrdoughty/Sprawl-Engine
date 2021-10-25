package systems;

import echoes.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import components.core.*;
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
            new Bounds2D(images.menubackground.width,images.menubackground.height),
            new Visible(true),
            new RenderOffset2D(0.0, 0.0));
        new Entity().add(
            new Position(Main.WIDTH /2 , Main.HEIGHT/2),
            new ImageComp(images.button),
            new AnimData(new StringMap()),
            new Scale(10,5),
            new Bounds2D(48,16),
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
            new Bounds2D(48,16),
            new Visible(true),
            new ButtonComp('credits'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, Main.HEIGHT/4),
            new Scale(10,30),
            new Visible(true),
            new TextComp("Git Gold",Assets.fonts._8bitlim,kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, Main.HEIGHT/4),
            new Scale(10,28),
            new Visible(true),
            new TextComp("Git Gold",Assets.fonts._8bitlim,kha.Color.Yellow)
        );
        if(Project.highScore>0)
        {
            new Entity().add(
                new Position(Main.WIDTH /2-145, Main.HEIGHT/4*3+27),
                new Scale(10,15),
                new Visible(true),
                new TextComp("High Score " + Project.highScore,Assets.fonts._8bitlim,kha.Color.Yellow)
            );
            new Entity().add(
                new Position(Main.WIDTH /2-145, Main.HEIGHT/4*3+127),
                new Scale(10,15),
                new Visible(true),
                new TextComp("Last Score " + Project.lastScore,Assets.fonts._8bitlim,kha.Color.Yellow)
            );
        }
    }

    @u public function mouseBtnUpdate (m:MouseComp, b:ButtonComp, p:Position, wh:Bounds2D, s:Scale)
    {
        var mPos = new Position(m.x,m.y);
        if(m.mousePressed[0] && Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            trace(b.tag+' down');
        }
        else if(m.mouseUp[0] && Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
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