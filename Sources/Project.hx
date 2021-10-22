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
import kha.audio1.AudioChannel;

import nape.geom.Vec2;
import nape.space.Space;
import nape.shape.Circle;

class Project {
	public var score:Int = 0;
	public var fps:Int = 0;
	public static var buffer:Framebuffer;
	public static var activeState:String = 'menu';
	public static var lastActiveState:String;
	public static var bgChannel:AudioChannel;
	public static var highScore:Int = 0;
	public static var lastScore:Int = 0;
	public var stateStartFunctions:StringMap<Void->Void>;

	public function new() 
	{
		System.notifyOnFrames(frameBufferCapture);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		stateStartFunctions = [
			'play'=>initGameSystems,
			'menu'=>initMenuSystems,
			'credits'=>initCreditSystems];
		lastActiveState = activeState;
		stateStartFunctions.get(activeState)();		
	}

	function update(): Void 
	{
		if(activeState != lastActiveState)
		{
			Workflow.reset();
			stateStartFunctions.get(activeState)();
		}
		lastActiveState = activeState; 


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
	
			
	public function initGameSystems() 
	{
		Workflow.addSystem(new GameSystem());
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
		
		//Renders after Animation stepping systems
		Workflow.addSystem(new Render());
		Workflow.addSystem(new ShapeRender());
		Workflow.addSystem(new CoinRender());
		Workflow.addSystem(new UI());
		
		//Add Inputs at the end because the update loop clears them 
		Workflow.addSystem(new Keyboard());
		Workflow.addSystem(new Mouse());
		Workflow.addSystem(new GamePadSystem());
	}
	
	public static function bufferCallback():Framebuffer
	{
		return buffer;
	}

	public function initMenuSystems() 
	{
		Workflow.addSystem(new StartMenu());
		//Renders after Animation stepping systems
		Workflow.addSystem(new Render());
		Workflow.addSystem(new ShapeRender());
		Workflow.addSystem(new UI());
		
		//Add Inputs at the end because the update loop clears them 
		Workflow.addSystem(new Keyboard());
		Workflow.addSystem(new Mouse());
		Workflow.addSystem(new GamePadSystem());
	}

	public function initCreditSystems() 
	{
		Workflow.addSystem(new CreditMenu());
		//Renders after Animation stepping systems
		Workflow.addSystem(new Render());
		Workflow.addSystem(new ShapeRender());
		Workflow.addSystem(new UI());
		
		//Add Inputs at the end because the update loop clears them 
		Workflow.addSystem(new Keyboard());
		Workflow.addSystem(new Mouse());
		Workflow.addSystem(new GamePadSystem());
	}
	
}
