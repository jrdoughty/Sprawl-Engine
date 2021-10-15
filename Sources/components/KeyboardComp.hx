package components;
import kha.input.KeyCode;

class KeyboardComp
{
	public var keysPressed:Map<KeyCode, Bool>;
	public var keysHeld:Map<KeyCode, Bool>;
	public var keysUp:Map<KeyCode, Bool>;
	public var keysCount:Int = 0;
	public var keysJustPressed:Bool = false;

	public function new()
	{	
		keysPressed = new Map<KeyCode, Bool>();
		keysHeld = new Map<KeyCode, Bool>();
		keysUp = new Map<KeyCode, Bool>();		
	}
}