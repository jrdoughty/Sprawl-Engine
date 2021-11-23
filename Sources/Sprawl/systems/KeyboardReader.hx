package sprawl.systems;

import kha.input.KeyCode;
import sprawl.components.*;

class KeyboardReader extends echoes.System
{	

	@a public function added(k:KeyboardState)
	{
		kha.input.Keyboard.get().notify(
			function(key:KeyCode){onKeyDown(key,k);}, 
			function(key:KeyCode){onKeyUp(key,k);});
	}
	@u public function update(k:KeyboardState):Void
	{
		for (key in k.keysPressed.keys())
			k.keysPressed.remove(key);

		for (key in k.keysUp.keys())
			k.keysUp.remove(key);

		k.keysJustPressed = false;
	}

	@r public function reset(k:KeyboardState):Void
	{
		for (key in k.keysPressed.keys())
			k.keysPressed.remove(key);

		for (key in k.keysHeld.keys())
			k.keysHeld.remove(key);

		for (key in k.keysUp.keys())
			k.keysUp.remove(key);
	}

	function onKeyDown(key:KeyCode,k:KeyboardState):Void
	{
		k.keysPressed.set(key, true);
		k.keysHeld.set(key, true);				            									        		

		k.keysCount++;
		k.keysJustPressed = true;
	}

	function onKeyUp(key:KeyCode,k:KeyboardState):Void
	{		
		k.keysUp.set(key, true);
		k.keysHeld.set(key, false);																					

		k.keysCount--;
	}

	inline public static function isPressed(key:KeyCode,k:KeyboardState):Bool
	{
		return k.keysPressed.exists(key);
	}

	inline public static function isHeld(key:KeyCode,k:KeyboardState):Bool
	{
		return k.keysHeld.get(key);
	}

	inline public static function isUp(key:KeyCode,k:KeyboardState):Bool
	{
		return k.keysUp.exists(key);
	}

	inline public static function isAnyHeld(k:KeyboardState):Bool
	{
		return (k.keysCount > 0);
	}

	inline public static function isAnyPressed(k:KeyboardState):Bool
	{
		return k.keysJustPressed;
	}
}