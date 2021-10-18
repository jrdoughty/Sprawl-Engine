package;

import kha.Worker;
import haxe.Constraints.Function;
import systems.Animation;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import systems.*;
import echoes.Workflow;
import haxe.ds.StringMap;
import kha.math.FastMatrix3;
import kha.graphics2.Graphics;
import kha.Color;
import kha.FastFloat;
import hxbit.Serializer;
import slide.Slide;

class Project {
	var characterEcho:Entity;

	public var numUnits:Int = 10;
	public var numPeople:Int = 10;
	public var score:Int = 0;
	public var fps:Int = 0;
	public var enemys:Array<Enemy> = [];
	public var enemiesEcho:Array<Entity> = [];
	public static var buffer:Framebuffer;

	public function initSystems() 
	{
		Workflow.addSystem(new Movement(Main.WIDTH, Main.HEIGHT));
		Workflow.addSystem(new Controls());
		Workflow.addSystem(new UnitIdleMovement());
		Workflow.addSystem(new EnemyUnitCollision());
		Workflow.addSystem(new MoveToTargetPosition());
		Workflow.addSystem(new Bounds(Main.WIDTH, Main.HEIGHT));
		Workflow.addSystem(new Animation());
		
		//Renders after Animation stepping systems
		var bufferCallback = function():Framebuffer{return buffer;};
		Workflow.addSystem(new Render(function():Framebuffer{return buffer;}));
		Workflow.addSystem(new UI(function():Framebuffer{return buffer;}));
		
		//Add Inputs at the end because the update loop clears them 
		Workflow.addSystem(new Keyboard());
		Workflow.addSystem(new Mouse());
		Workflow.addSystem(new GamePadSystem());
	}

	public function new() 
	{
		initSystems();

		System.notifyOnFrames(frameBufferCapture);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		var images = Assets.images;
		
		var s = new Serializer();
		var b = s.serialize(new Vec2(5,5));
		trace(s.unserialize(b,Vec2).x);
		var sEntity = new Entity().add(
			new ScoreComp(1));
		characterEcho = new Entity().add(
			new Position(Main.WIDTH /2 , Main.HEIGHT-Main.HEIGHT/5),
			new Velocity(0,0),
			new Player(),
			AnimComp.createAnimDataRange(0,3,Math.round(100)),
			new ImageComp(images.main),
			new AnimData(new StringMap()),
			new Scale(1,1),
			new WHComp(32,32),
			new Visible(true),
			new GamePad(0),
			new KeyboardComp(),
			new MouseComp()
		);
		
		var i;
		for(i in 0...numUnits)
		{
			var speed = (Math.random()+.5)*40;
			enemiesEcho.push(new Entity().add(//(.4+Math.random()/8)
				Utils.findRandomPointInCircle(characterEcho.get(Position),64),
				new Velocity(0,0),
				new Scale(1,1),
				new ImageComp(images.alt),
				AnimComp.createAnimDataRange(0,3,Math.round(speed)),
				new WHComp(32,32),
				new AnimData(new StringMap()),
				new Visible(true),
				new Angle(0),//360 * Math.random())
				new KeyboardComp(),
				new Unit(Math.round(120 * Math.random())),
				new MouseComp()
			));
		}
		for(i in 0...numPeople)
		{
			var speed = (Math.random()+.5)*40;
			enemiesEcho.push(new Entity().add(//(.4+Math.random()/8)
				new Position(Main.WIDTH * Math.random(), Main.HEIGHT * Math.random() ),
				new Velocity(0,0),
				new Scale(1,1),
				new ImageComp(images.peep),
				new Enemy(),
				AnimComp.createAnimDataRange(0,3,Math.round(speed)),
				new WHComp(32,32),
				new AnimData(new StringMap()),
				new Visible(true),
				new Angle(0)//360 * Math.random())
			));
		}
	}

	function update(): Void 
	{
		Slide.step(60/1000);
		Workflow.update(60 / 1000);
		
	}

	function frameBufferCapture(framebuffers: Array<Framebuffer>): Void 
	{
		buffer = framebuffers[0];//obviously has to happen before the Workflow.draw
		
        buffer.g2.begin(true,Color.Blue);
		Workflow.draw();
        buffer.g2.end();
		score++;
	}
	
	
}
