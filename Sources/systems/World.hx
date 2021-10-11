package systems;

import components.*;

class LevelComp
{
	public var activeNodes:Array<NodeComp> = [];

	public var tileset:RTSTileset;
	public var levelWidth:Int;
	public var levelHeight:Int;
	public var playerStartPos:Map<Int, Vec2> = new Map<Int, Vec2>();

	private var diagonal:Bool = true;
}
class RTSLevelComp extends LevelComp
{
	public var neutralEnemyPos:Array<Vec2> = [];
	public var resourcePos:Array<Vec2> = [];
}


class Tileset
{	
	var region:Region;
	public var tileWidth:Int;
	public var tileHeight:Int;
	public var widthInTiles:Int;
	public var heightInTiles:Int;	
	
	// temp variables
	var _x:Int;
	var _y:Int;
}

typedef Tile = {
	var id:Int;
	var type:String;
}
class RTSTileset extends Tileset
{	
	public var specialTiles:Array<Tile>= [];
}
class World {
    public function new() {
        
    }
}