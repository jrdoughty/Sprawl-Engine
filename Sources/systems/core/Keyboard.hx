package systems.core;

import kha.input.KeyCode;
import components.core.*;
class Keyboard extends echoes.System
{	

	@a public function added(k:KeyboardComp)
	{
		kha.input.Keyboard.get().notify(
			function(key:KeyCode){onKeyDown(key,k);}, 
			function(key:KeyCode){onKeyUp(key,k);});
	}
	@u public function update(k:KeyboardComp):Void
	{
		for (key in k.keysPressed.keys())
			k.keysPressed.remove(key);

		for (key in k.keysUp.keys())
			k.keysUp.remove(key);

		k.keysJustPressed = false;
	}

	@r public function reset(k:KeyboardComp):Void
	{
		for (key in k.keysPressed.keys())
			k.keysPressed.remove(key);

		for (key in k.keysHeld.keys())
			k.keysHeld.remove(key);

		for (key in k.keysUp.keys())
			k.keysUp.remove(key);
	}

	function onKeyDown(key:KeyCode,k:KeyboardComp):Void
	{
		k.keysPressed.set(key, true);
		k.keysHeld.set(key, true);				            									        		

		k.keysCount++;
		k.keysJustPressed = true;
	}

	function onKeyUp(key:KeyCode,k:KeyboardComp):Void
	{		
		k.keysUp.set(key, true);
		k.keysHeld.set(key, false);																					

		k.keysCount--;
	}

	inline public static function isPressed(key:KeyCode,k:KeyboardComp):Bool
	{
		return k.keysPressed.exists(key);
	}

	inline public static function isHeld(key:KeyCode,k:KeyboardComp):Bool
	{
		return k.keysHeld.get(key);
	}

	inline public static function isUp(key:KeyCode,k:KeyboardComp):Bool
	{
		return k.keysUp.exists(key);
	}

	inline public static function isAnyHeld(k:KeyboardComp):Bool
	{
		return (k.keysCount > 0);
	}

	inline public static function isAnyPressed(k:KeyboardComp):Bool
	{
		return k.keysJustPressed;
	}
}