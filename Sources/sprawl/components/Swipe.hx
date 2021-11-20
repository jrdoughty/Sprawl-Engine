package sprawl.components;


class Swipe  implements hxbit.Serializable 
{
	@:s public var start:Vec2;
	@:s public var end:Vec2;

	public function new(start:Vec2, end:Vec2):Void
	{
		this.start = start;
		this.end = end;
	}	
}