package components;

import kha.math.Vector2;

class GamePad
{

	public static inline var A_X:Int = 0;
	public static inline var B_CIRCLE:Int = 1;
	public static inline var X_SQUARE:Int = 2;
	public static inline var Y_TRIANGLE:Int = 3;
	public static inline var LBL1:Int = 4;
	public static inline var RBR1:Int = 5;
	public static inline var LEFT_ANALOG_PRESS:Int = 6;
	public static inline var RIGHT_ANALOG_PRESS:Int = 7;
	public static inline var START:Int = 8;
	public static inline var BACK_SELECT:Int = 9;
	public static inline var HOME:Int = 10;
	public static inline var DUP:Int = 11;
	public static inline var DDOWN:Int = 12;
	public static inline var DLEFT:Int = 13;
	public static inline var DRIGHT:Int = 14;

	public var id:Int;
	public var active:Bool;

	public var leftAnalog:Vector2;
	public var rightAnalog:Vector2;
	public var leftTrigger:Float = 0;
	public var rightTrigger:Float = 0;
	
	public var buttonsPressed:Map<Int, Bool>;
	public var buttonsHeld:Map<Int, Bool>;
	public var buttonsUp:Map<Int, Bool>;
	public var buttonsCount:Int;
	public var buttonsJustPressed:Bool;	
	
	public function new(id:Int)
	{
		this.id = id;
		leftAnalog = new Vector2(0, 0);
		rightAnalog = new Vector2(0, 0);
		leftTrigger = 0;
		rightTrigger = 0;
		buttonsPressed = new Map<Int, Bool>();
		buttonsHeld = new Map<Int, Bool>();
		buttonsUp = new Map<Int, Bool>();
		buttonsCount = 0;
		buttonsJustPressed = false;	
	}

}