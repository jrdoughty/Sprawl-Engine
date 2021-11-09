package systems;

import haxe.macro.Type;
import serialization.WorkflowData;
import echoes.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import components.core.*;
import haxe.ds.StringMap;
import hxbit.Serializer;
import echoes.Workflow;


class StartMenu extends System
{
    public function new() {
        var speed = 5;
        var images = Assets.images;
        
        new Entity().add(//Background
            new Position(0, 0),
            new ImageComp("menubackground"),
            new Scale(Main.WIDTH/images.menubackground.width,Main.HEIGHT/images.menubackground.height),
            new Bounds2D(images.menubackground.width,images.menubackground.height),
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
            new Visibility(.05,true),
            new ButtonComp('credits'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, Main.HEIGHT/4),
            new Scale(10,30),
            new Visibility(),
            new TextComp("Git Gold","_8bitlim",kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, Main.HEIGHT/4),
            new Scale(10,28),
            new Visibility(),
            new TextComp("Git Gold","_8bitlim",kha.Color.Yellow)
        );
        if(Project.highScore>0)
        {
            new Entity().add(
                new Position(Main.WIDTH /2-145, Main.HEIGHT/4*3+27),
                new Scale(10,15),
                new Visibility(),
                new TextComp("High Score " + Project.highScore,"_8bitlim",kha.Color.Yellow)
            );
            new Entity().add(
                new Position(Main.WIDTH /2-145, Main.HEIGHT/4*3+127),
                new Scale(10,15),
                new Visibility(),
                new TextComp("Last Score " + Project.lastScore,"_8bitlim",kha.Color.Yellow)
            );
        }

        var s = new Serializer();
        var d = new WorkflowData();
        for(i in Workflow.entities)
        {
            d.entities.push(i);
            d.idPool.push(i);
            d.status.push(i.status());
            trace('-----------------------');
            if(i.exists(Position))
            {
                var seri = new haxe.Serializer();
                seri.serialize(i.get(Position));
                trace(seri.toString());
            }
            if(i.exists(Bounds2D))
            {
                var seri = new haxe.Serializer();
                seri.serialize(i.get(Bounds2D));
                trace(seri.toString());
            }
            if(i.exists(MouseComp))
            {
                var seri = new haxe.Serializer();
                seri.serialize(i.get(MouseComp));
                trace(seri.toString());
            }
            if(i.exists(TextComp))
            {
                var seri = new haxe.Serializer();
                seri.serialize(i.get(TextComp));
                trace(seri.toString());
            }
            for(j in i.print().substr(3,i.print().length-3).split('},'))
            {
                var name = j.substr(0,j.indexOf('='));
                var stri = ('cy'+name.length+":"+name);
                for(k in j.substr(j.indexOf('{')+1,(j.length-1-j.indexOf('{'))).split(','))
                {
                    k = StringTools.replace(k, '\n','');
                    k = StringTools.replace(k, '\t','');
                    k = StringTools.replace(k,' ','');
                    k = StringTools.replace(k,'}','');
                    var vari = k.split(':')[0];
                    var val = k.split(':')[1];
                    stri += ('y'+vari.length+':'+ vari);
                    var num = Std.parseInt(val);
                    if(num == Math.NaN || num == null)
                        stri += ('y'+val.length + val);
                    else
                    {
                        if(Std.parseFloat(val)%1>0)
                        {
                            stri += ('d'+ val);
                        }
                        else 
                        {
                            stri += ('i'+ val);
                        }
                    }
                }
                stri += ('g');
                trace(stri);
                /*
                j = j.split('{')[0];
                if(j.indexOf('.')!=-1 && j.indexOf('=')!=-1 )
                {
                    var name = (j.substr(j.indexOf('.')+1,j.indexOf('=')-1-j.indexOf('.')));
                    trace('cy'+name.length+name);
                }*/
            }
            var unserializer = new haxe.Unserializer(i.print()); 
            //trace(unserializer.unserialize());

        }
        var result = new haxe.Unserializer('cy24:components.core.Positiony5:__uidi29y1:yd174.5y1:xi310g').unserialize();
        //trace(result);
        //var bytes = s.serialize(d);
        //trace(s.unserialize(bytes, WorkflowData));
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