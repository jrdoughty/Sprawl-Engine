package components.core;

class MouseComp implements hxbit.Serializable {

	@:s public var init:Bool = false;	
	/**
	 * x not scaled
	 */
	@:s public var rawX:Int = 0;
	/**
	 * y not scaled
	 */
	@:s public var rawY:Int = 0;	
	/**
	 * x scaled to the backbuffer
	 */
	@:s public var x:Int = 0;
	/**
	 * y scaled to the backbuffer
	 */
	@:s public var y:Int = 0;
	/**
	 * last x position when a mouse click started, scaled to the backbuffer
	 */
	@:s public var sx:Int = 0;
	/**
	 * last y position when a mouse click started, scaled to the backbuffer
	 */
	@:s public var sy:Int = 0;

	/**
	 * delta of x
	 */
	@:s public var dx:Int = 0;
	/**
	 * delta of y
	 */
	@:s public var dy:Int = 0;	
	/**
	 * TODO
	 * x inside the world (adjusted with the camera)
	 */
	@:s public var wx:Int = 0;
	/**
	 * TODO
	 * y inside the world (adjusted with the camera)
	 */
	@:s public var wy:Int = 0;
	@:s public var durationMouseDown:Float = 0;
	@:s public var mouseDownStartTime:Float;
	@:s public var mousePressed:Map<Int, Bool>;
	@:s public var mouseHeld:Map<Int, Bool>;
	@:s public var mouseUp:Map<Int, Bool>;
	@:s public var mouseCount:Int = 0;
	@:s public var mouseJustPressed:Bool = false;

    
    public function new() {
		mousePressed = new Map<Int, Bool>();
		mouseHeld = new Map<Int, Bool>();
		mouseUp = new Map<Int, Bool>();
		init = true;
    }
}