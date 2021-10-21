package;

import nape.shape.Polygon;
import nape.phys.BodyType;
import nape.phys.Body;
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

import nape.geom.Vec2;
import nape.space.Space;
import nape.shape.Circle;

class Project {
	public var numUnits:Int = 10;
	public var numPeople:Int = 10;
	public var numCollectors:Int = 10;
	public var score:Int = 0;
	public var fps:Int = 0;
	public static var buffer:Framebuffer;
	public static var active:Bool = true;


	public function new() 
	{
		initGameSystems();
		System.notifyOnFrames(frameBufferCapture);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		gameEntityCreate();
	}

	function update(): Void 
	{
		if(!Project.active)
		{
			Workflow.reset();
			initMenuSystems();
			Project.active = true;
		}
		Slide.step(1 / 60);
		Workflow.update(1 / 60);
	}

	function frameBufferCapture(framebuffers: Array<Framebuffer>): Void 
	{
		buffer = framebuffers[0];//obviously has to happen before the Workflow.draw
		
        buffer.g2.begin(true, Color.Black);
		//if(active)
		{
			Workflow.draw();
		}
		buffer.g2.end();
		score++;
	}
	
	public function gameEntityCreate() 
	{
			var speed = 5;
			var images = Assets.images;
			var sEntity = new Entity().add(
				new ScoreComp(0),
				new TimeComp(["timer"=>new TimeData(1)]));
			
			new Entity().add(//Background
				new Position(0, 0),
				AnimComp.createAnimDataRange(0,0,Math.round(100)),
				new ImageComp(images.back),
				new Scale(1,1),
				new WHComp(Main.WIDTH,Main.HEIGHT),
				new WHComp(Main.WIDTH,Main.HEIGHT),
				new Visible(true),
				new TopLeftRender(true));
	
	
			var characterEcho = new Entity().add(
				new Position(Main.WIDTH /2 , Main.HEIGHT/2),
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
				new Entity().add(//(.4+Math.random()/8)
					Utils.findRandomPointInCircle(characterEcho.get(Position),64),
					new Velocity(0,0),
					new Scale(1,1),
					new ImageComp(images.alt),
					AnimComp.createAnimDataRange(0,3,Math.round(speed)),
					new WHComp(32,32),
					new AnimData([
						"idle"=>AnimComp.createAnimDataRange(0,0,Math.round(speed)),
						"run"=>AnimComp.createAnimDataRange(0,2,Math.round(speed))]),
					new Visible(true),
					new Angle(0),
					new Unit(Math.round(120 * Math.random()))
				);
			}
			
			for(i in 0...numPeople)
			{
				new Entity().add(//(.4+Math.random()/8)
					new Position(Main.WIDTH * Math.random(), Main.PLAYAREAHEIGHT * Math.random() ),
					new Velocity(0,0),
					new Scale(1,1),
					new ImageComp(images.peep),
					new Enemy(),
					AnimComp.createAnimDataRange(0,3,Math.round(speed)),
					new WHComp(32,32),
					new AnimData([
						"idle"=>AnimComp.createAnimDataRange(2,2,Math.round(speed)),
						"run"=>AnimComp.createAnimDataRange(0,3,Math.round(speed))]),
					new Visible(true),
					new Angle(0)//360 * Math.random())
				);
			}
			for(i in 0...120)
			{
				var c = new Circle(5);
				var body = new Body(BodyType.STATIC, new Vec2((30 * i) % Main.WIDTH, 800 - 30*Math.floor(i/30)));
				if(Math.floor(i/30)%2==0)
					body.position.x += 15;
				c.body = body;
				new Entity().add(c,
					new ImageComp(Assets.images.peg),
					AnimComp.createAnimDataRange(0,0,Math.round(100)),
					new Angle(0));
			}
			//floor
			var poly:Polygon = new Polygon(Polygon.rect(0,0,Main.WIDTH,10));
			poly.body = new Body(BodyType.STATIC, new Vec2(0, Main.HEIGHT));
			new Entity().add(poly);
			//walls
			poly = new Polygon(Polygon.rect(0,0,10,Main.HEIGHT));
			poly.body = new Body(BodyType.STATIC, new Vec2(-9, 0));
			new Entity().add(poly);
			poly = new Polygon(Polygon.rect(0,0,10,Main.HEIGHT));
			poly.body = new Body(BodyType.STATIC, new Vec2(Main.WIDTH, 0));
			new Entity().add(poly);
	
			for(i in 0...numCollectors)
			{
				if(i%6==2)
				{
					new Entity().add(
						new Position(Main.WIDTH/numCollectors*i,Main.HEIGHT-32),
						new Velocity(0,0),
						new Scale(1,1),
						new ImageComp(images.ogre),
						AnimComp.createAnimDataRange(0,3,Math.round(speed)),
						new WHComp(32,64),
						new AnimData([
							"idle"=>AnimComp.createAnimDataRange(0,0,Math.round(speed)),
							"run"=>AnimComp.createAnimDataRange(0,3,Math.round(speed))]),
						new Visible(true),
						new Angle(0),
						new Catcher(Math.round(120),3)
					);
				}
				else if(i%6==4)
				{
					new Entity().add(
						new Position(Main.WIDTH/numCollectors*i,Main.HEIGHT-16),
						new Velocity(0,0),
						new Scale(1,1),
						new ImageComp(images.goblinbigbag),
						AnimComp.createAnimDataRange(0,2,Math.round(speed)),
						new WHComp(32,32),
						new AnimData([
							"idle"=>AnimComp.createAnimDataRange(3,5,Math.round(speed)),
							"run"=>AnimComp.createAnimDataRange(0,2,Math.round(speed))]),
						new Visible(true),
						new Angle(0),
						new Catcher(Math.round(200),5)
					);
				}
				else 
				{
					new Entity().add(
						new Position(Main.WIDTH/numCollectors*i,Main.HEIGHT-16),
						new Velocity(0,0),
						new Scale(1,1),
						new ImageComp(images.alt),
						AnimComp.createAnimDataRange(0,3,Math.round(speed)),
						new WHComp(32,32),
						new AnimData([
							"idle"=>AnimComp.createAnimDataRange(0,0,Math.round(speed)),
							"run"=>AnimComp.createAnimDataRange(0,2,Math.round(speed))]),
						new Visible(true),
						new Angle(0),
						new Catcher(Math.round(60),1)
					);
				}
			}
			var debImages = [images.tree,images.barrel,images.bottle, images.shovel, images.box];
			for(i in 0...numPeople*4)
			{
				new Entity().add(
					new Position(Math.random()*Main.WIDTH,Math.random()*Main.PLAYAREAHEIGHT),
					new Scale(1,1),
					new ImageComp(debImages[(i%debImages.length)]),
					AnimComp.createAnimDataRange(0,0,Math.round(speed)),
					new WHComp(debImages[(i%debImages.length)].width,debImages[(i%debImages.length)].height),
					new Visible(true),
					new Debris()
				);
			}
	}

	public function menuEntityCreate() 
	{
	
	
			
	}
			
	public function initGameSystems() 
	{
		Workflow.addSystem(new Movement());
		Workflow.addSystem(new Controls());
		Workflow.addSystem(new PhysicsSystem());
		Workflow.addSystem(new IdleMovement());
		Workflow.addSystem(new EnemyAttack());
		Workflow.addSystem(new EnemyUnitCollision());
		Workflow.addSystem(new DebrisUnitCollision());
		Workflow.addSystem(new MoveToTargetPosition());
		Workflow.addSystem(new CatcherCollectSystem());
		Workflow.addSystem(new Animation());
		Workflow.addSystem(new TimeSystem());
		
		//Renders after Animation stepping systems
		Workflow.addSystem(new Render(bufferCallback));
		Workflow.addSystem(new ShapeRender(bufferCallback));
		Workflow.addSystem(new CoinRender(bufferCallback));
		Workflow.addSystem(new UI(bufferCallback));
		
		//Add Inputs at the end because the update loop clears them 
		Workflow.addSystem(new Keyboard());
		Workflow.addSystem(new Mouse());
		Workflow.addSystem(new GamePadSystem());
	}
	
	public function bufferCallback():Framebuffer
	{
		return buffer;
	}

	public function initMenuSystems() 
	{
		Workflow.addSystem(new StartMenu());
		//Renders after Animation stepping systems
		Workflow.addSystem(new Render(bufferCallback));
		Workflow.addSystem(new ShapeRender(bufferCallback));
		Workflow.addSystem(new UI(bufferCallback));
		
		//Add Inputs at the end because the update loop clears them 
		Workflow.addSystem(new Keyboard());
		Workflow.addSystem(new Mouse());
		Workflow.addSystem(new GamePadSystem());
	}
	
}
