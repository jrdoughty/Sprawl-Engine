package sprawl.components;


class GamePad implements hxbit.Serializable 
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

	@:s public var id:Int;
	@:s public var active:Bool;

	@:s public var leftAnalog:Vec2 = new Vec2(0, 0);
	@:s public var rightAnalog:Vec2 = new Vec2(0, 0);
	@:s public var leftTrigger:Float = 0;
	@:s public var rightTrigger:Float = 0;
	
	@:s public var buttonsPressed:Map<Int, Bool> = new Map<Int, Bool>();
	@:s public var buttonsHeld:Map<Int, Bool> = new Map<Int, Bool>();
	@:s public var buttonsUp:Map<Int, Bool> = new Map<Int, Bool>();
	@:s public var buttonsCount:Int = 0;
	@:s public var buttonsJustPressed:Bool = false;	
	
	public function new(id:Int)
	{
		this.id = id;
	}

}