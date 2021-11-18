package systems;

#if js 
import js.Browser;
#else
import sys.io.File;
#end
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
        //seri.unserialize(b);
        var bs = AssetRepo.blobs;
        #if js
        Browser.getLocalStorage().setItem('test.txt',bs.get('startmenu_txt').toString());
        Workflow.load(Browser.getLocalStorage().getItem('test.txt'));
        #else
        File.saveContent('test.txt',bs.get('startmenu_txt').toString());
        Workflow.load(File.getContent('test.txt'));
        #end
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