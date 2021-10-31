package components.core;
import kha.input.KeyCode;

class KeyboardComp implements hxbit.Serializable
{
	@:s public var keysPressed:Map<KeyCode, Bool>;
	@:s public var keysHeld:Map<KeyCode, Bool>;
	@:s public var keysUp:Map<KeyCode, Bool>;
	@:s public var keysCount:Int = 0;
	@:s public var keysJustPressed:Bool = false;

	public function new()
	{	
		keysPressed = new Map<KeyCode, Bool>();
		keysHeld = new Map<KeyCode, Bool>();
		keysUp = new Map<KeyCode, Bool>();		
	}
}