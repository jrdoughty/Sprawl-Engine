package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import echoes.Workflow;
import haxe.ds.StringMap;
import kha.audio1.AudioChannel;
import haxe.Timer;
import slide.Slide;
import systems.*;
import systems.core.*;

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
	public var updateTime:Float;

	public function new() 
	{
		System.notifyOnFrames(frameBufferCapture);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		updateTime = Timer.stamp();
		stateStartFunctions = [
			'play'=>initGameSystems,
			'menu'=>initMenuSystems,
			'credits'=>initCreditSystems];
		lastActiveState = activeState;
		stateStartFunctions.get(activeState)();		
	}

	function update(): Void 
	{
		var newUpdate = Timer.stamp();
		var dt:Float = newUpdate - updateTime;
		updateTime = newUpdate;
		if(activeState != lastActiveState)
		{
			Workflow.reset();
			stateStartFunctions.get(activeState)();
		}
		lastActiveState = activeState; 


		Slide.step(dt);
		Workflow.update(dt);
	}

	function frameBufferCapture(framebuffers: Array<Framebuffer>): Void 
	{
		buffer = framebuffers[0];//obviously has to happen before the Workflow.draw
		
        buffer.g2.begin(true, kha.Color.Black);
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
		Workflow.addSystem(new Controls());
		Workflow.addSystem(new PhysicsSystem());
		Workflow.addSystem(new IdleMovement());
		Workflow.addSystem(new EnemyUnitCollision());
		Workflow.addSystem(new DebrisUnitCollision());
		Workflow.addSystem(new MoveToTargetPosition());
		Workflow.addSystem(new CatcherCollectSystem());
		Workflow.addSystem(new Animation());
		
		//Renders after Animation stepping systems
		Workflow.addSystem(new PhysicsStateTransformer());
		Workflow.addSystem(new SpriteRender());
		Workflow.addSystem(new ShapeRender());
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
		Workflow.addSystem(new SpriteRender());
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
		Workflow.addSystem(new SpriteRender());
		Workflow.addSystem(new UI());
		
		//Add Inputs at the end because the update loop clears them 
		Workflow.addSystem(new Keyboard());
		Workflow.addSystem(new Mouse());
		Workflow.addSystem(new GamePadSystem());
	}
	
}
