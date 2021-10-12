package;

import systems.Animation;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import echoes.Workflow;
import components.AnimComp.AnimData;
import haxe.ds.StringMap;
import kha.math.FastMatrix3;
import kha.graphics2.Graphics;
import kha.Color;
import kha.FastFloat;

class Project {
	var characterEcho:Entity;
	public var numEnemys:Int = 1000;
	public var score:Int = 0;
	public var fps:Int = 0;
	public var enemys:Array<Enemy> = [];
	public var enemiesEcho:Array<Entity> = [];
	public static var buffer:Framebuffer;

	public function new() 
	{
		System.notifyOnFrames(frameBufferCapture);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		Scheduler.addTimeTask(secondTick, 0, 1);
		var images = Assets.images;
		characterEcho = new Entity().add(
			new Position(Main.WIDTH /2 , Main.HEIGHT-Main.HEIGHT/5),
			new Velocity(0,0),
			new components.Player(),
			AnimComp.createAnimDataRange(0,3,Math.round(1000000)),
			new ImageComp(images.main),
			new Scale(1,1),
			new WH(32,32),
			new Visible(true)
		);
		var i;
		for(i in 0...numEnemys)
		{
			var speed = (Math.random()+.5)*40;
			var scale = Math.random()*3;
			enemiesEcho.push(new Entity().add(
				new Position(Main.WIDTH * Math.random(), 0),
				new Velocity(0,(Math.random()+.5)*40),
				new components.Enemy(),
				new Scale(scale,scale),
				new ImageComp(images.alt),
				AnimComp.createAnimDataRange(0,3,Math.round(speed)),
				new WH(32,32),
				new AnimData(new StringMap()),
				new Visible(true),
				new Angle(360 * Math.random())
			));
		}
	}

	function update(): Void 
	{
		Workflow.update(60 / 1000);
	}

	function secondTick(): Void 
	{
		fps = score;
		score = 0;
	}
	function frameBufferCapture(framebuffers: Array<Framebuffer>): Void 
	{
		buffer = framebuffers[0];
		score++;
	}
	
	
}
