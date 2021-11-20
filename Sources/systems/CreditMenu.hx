package systems;

import echoes.System;
import echoes.Entity;
import components.*;
import components.core.*;
import haxe.ds.StringMap;

class CreditMenu extends System
{
    public function new() {
        
        new Entity().add(//Background
            new Position(0, 0),
            new ImageComp("menubackground"),
            new Scale(Main.WIDTH/AssetRepo.images.get("menubackground").width,
                Main.HEIGHT/AssetRepo.images.get("menubackground").height),
            new Bounds2D(AssetRepo.images.get("menubackground").width,
                AssetRepo.images.get("menubackground").height),
            new Visibility(),
            new RenderOffset2D(0.0, 0.0));
        new Entity().add(
            new Position(Main.WIDTH /2 , Main.HEIGHT/2),
            new ImageComp("button"),
            new AnimData(new StringMap()),
            new Scale(10,5),
            new Bounds2D(48,16),
            new Visibility(),
            new ButtonComp('play'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
        new Entity().add(
            new Position(Main.WIDTH /2, Main.HEIGHT/2 + 96),
            new ImageComp("button"),
            new AnimData(new StringMap()),
            new Scale(10,5),
            new Bounds2D(48,16),
            new Visibility(),
            new ButtonComp('menu'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, 85),
            new Scale(10,18),
            new Visibility(),
            new TextComp("John Doughty","_8bitlim",kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, 85),
            new Scale(10,17.5),
            new Visibility(),
            new TextComp("John Doughty","_8bitlim",kha.Color.Yellow)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, 215),
            new Scale(10,15.5),
            new Visibility(),
            new TextComp("Art and Code","_8bitlim",kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, 215),
            new Scale(10,15),
            new Visibility(),
            new TextComp("Art and Code","_8bitlim",kha.Color.Yellow)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, 590),
            new Scale(10,10),
            new Visibility(),
            new TextComp("Special Thanks","_8bitlim",kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, 590),
            new Scale(10,9.5),
            new Visibility(),
            new TextComp("Special Thanks","_8bitlim",kha.Color.Yellow)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, 660),
            new Scale(10,9.75),
            new Visibility(),
            new TextComp("Ben Immel and Nick Cash","_8bitlim",kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, 660),
            new Scale(10,9.5),
            new Visibility(),
            new TextComp("Ben Immel and Nick Cash","_8bitlim",kha.Color.Yellow)
        );
    }

    @u public function mouseBtnUpdate (m:MouseComp, b:ButtonComp, p:Position, wh:Bounds2D, s:Scale)
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