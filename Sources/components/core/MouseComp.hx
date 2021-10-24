package components.core;

class MouseComp implements hxbit.Serializable {

	public var init:Bool = false;	
	/**
	 * x not scaled
	 */
	public var rawX:Int = 0;
	/**
	 * y not scaled
	 */
	public var rawY:Int = 0;	
	/**
	 * x scaled to the backbuffer
	 */
	public var x:Int = 0;
	/**
	 * y scaled to the backbuffer
	 */
	public var y:Int = 0;
	/**
	 * last x position when a mouse click started, scaled to the backbuffer
	 */
	public var sx:Int = 0;
	/**
	 * last y position when a mouse click started, scaled to the backbuffer
	 */
	public var sy:Int = 0;

	/**
	 * delta of x
	 */
	public var dx:Int = 0;
	/**
	 * delta of y
	 */
	public var dy:Int = 0;	
	/**
	 * x inside the world (adjusted with the camera)
	 */
	public var wx:Int = 0;
	/**
	 * y inside the world (adjusted with the camera)
	 */
	public var wy:Int = 0;

	public var durationMouseDown:Float = 0;

	public var mouseDownStartTime:Float;

	public var mousePressed:Map<Int, Bool>;
	public var mouseHeld:Map<Int, Bool>;
	public var mouseUp:Map<Int, Bool>;
	public var mouseCount:Int = 0;
	public var mouseJustPressed:Bool = false;

    
    public function new() {
		mousePressed = new Map<Int, Bool>();
		mouseHeld = new Map<Int, Bool>();
		mouseUp = new Map<Int, Bool>();
		init = true;
    }
}