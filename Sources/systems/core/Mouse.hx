package systems.core;

import kha.input.Mouse;
import kha.math.Vector2;
import kha.System;
import components.core.*;

class Mouse extends echoes.System
{
	public function new(){}
	@a public function added(m:MouseComp)
	{
		kha.input.Mouse.get().notify(
			function(index:Int, x:Int, y:Int){onMouseStart(index,x,y,m);}, 
			function(index:Int, x:Int, y:Int){onMouseEnd(index,x,y,m);}, 
			function(x:Int, y:Int,dx:Int,dy:Int){onMouseMove(x,y,dx,dy,m);}, 
			function(delta:Int){onMouseWheel(delta);});
	}
	@u public function update(m:MouseComp):Void
	{
		for (key in m.mousePressed.keys())
			m.mousePressed.remove(key);

		for (key in m.mouseUp.keys())
			m.mouseUp.remove(key);

		m.mouseJustPressed = false;
	}

	@r public function reset(m:MouseComp):Void
	{

		for (key in m.mousePressed.keys())
			m.mousePressed.remove(key);

		for (key in m.mouseHeld.keys())
			m.mouseHeld.remove(key);

		for (key in m.mouseUp.keys())
			m.mouseUp.remove(key);
	}

	function onMouseStart(index:Int, x:Int, y:Int, m:MouseComp):Void
	{
		updateMouseData(x, y, 0, 0, m);

		m.sx = Std.int(x);// * Sdg.gameScale);
		m.sy = Std.int(y);// * Sdg.gameScale);

		m.mousePressed.set(index, true);
		m.mouseHeld.set(index, true);

		m.mouseCount++;

		m.mouseJustPressed = true;

		m.mouseDownStartTime = kha.Scheduler.time();
	}

	function onMouseEnd(index:Int, x:Int, y:Int, m:MouseComp):Void
	{
		updateMouseData(x, y, 0, 0, m);

		m.mouseUp.set(index, true);
		m.mouseHeld.remove(index);

		m.mouseCount--;

		m.durationMouseDown = kha.Scheduler.time() - m.mouseDownStartTime;
	}

	function onMouseMove(x:Int, y:Int, dx:Int, dy:Int, m:MouseComp):Void
	{
		updateMouseData(x, y, dx, dy, m);
	}

	function updateMouseData(x:Int, y:Int, dx:Int, dy:Int, m:MouseComp):Void
	{
		m.rawX = x;
		m.rawY = y;

		var sysW = System.windowWidth();
		var sysH = System.windowHeight();
		var ratio = Main.WIDTH / Main.HEIGHT;
		var sysRatio = sysW / sysH;

		var effectiveWidth;//the width of the game in the window
		var effectiveHeight;//the height of the game in the window

		if(sysRatio > ratio)
		{
			effectiveWidth = Std.int(sysH * ratio);
			effectiveHeight = sysH;
		}
		else
		{
			effectiveHeight = Std.int(sysW / ratio);
			effectiveWidth = sysW;
		}
		var diff = (sysW - effectiveWidth)/2;

		x = Std.int(x - diff);
		x = Std.int(x/effectiveWidth * Main.WIDTH);//Sdg.windowWidth);
		if(x < 0) x = 0;
		if(x >  Main.WIDTH) x =  Main.WIDTH;//Sdg.windowWidth;

		diff = (sysH - effectiveHeight)/2;
		y = Std.int(y - diff);
		y = Std.int(y / effectiveHeight  * Main.HEIGHT);
		if(y < 0) y = 0;
		if(y > Main.HEIGHT) y = Main.HEIGHT;

		m.x = Std.int(x);// / Sdg.gameScale);
		m.y = Std.int(y);// / Sdg.gameScale);
		m.dx = Std.int(dx);// / Sdg.gameScale);
		m.dy = Std.int(dy);// / Sdg.gameScale);
		
		if (true)//Sdg.screen != null)
		{
			m.wx = Std.int((x)); //+ Sdg.screen.camera.x) / Sdg.gameScale);
			m.wy = Std.int((y));// + Sdg.screen.camera.y) / Sdg.gameScale);
		}
	}

	function onMouseWheel(delta:Int):Void
	{
		// TODO
		trace("onMouseWheel : " + delta);
	}
	
	inline public static function isPressed(index:Int,m:MouseComp):Bool
		{
			return m.init && m.mousePressed.exists(index);
		}
	
		inline public static function isHeld(index:Int,m:MouseComp):Bool
		{
			return m.init && m.mouseHeld.exists(index);
		}
	
		inline public static function isUp(index:Int,m:MouseComp):Bool
		{
			return m.init && m.mouseUp.exists(index);
		}
	
		inline public static function isAnyHeld(m:MouseComp):Bool
		{
			return m.init && (m.mouseCount > 0);
		}
	
		inline public static function isAnyPressed(m:MouseComp):Bool
		{
			return m.init && m.mouseJustPressed;
		}
	
		public static function checkSwipe(distance:Int = 30, timeFrom:Float = 0.1, timeUntil:Float = 0.25, m:MouseComp):Swipe
		{
			var swipeOcurred = (isHeld(0,m) && Math.round(Utils.distance(m.sx, m.sy, m.x, m.y)) > distance
				&& m.durationMouseDown > timeFrom && m.durationMouseDown < timeUntil);									
	
			if (swipeOcurred)
				return new Swipe(new Vec2(m.sx, m.sy), new Vec2(m.x, m.y));
			else
				return null;
		}
	
		public static function getPos(m:MouseComp):Position
		{
			return new Position(m.x,m.y);
		}
}