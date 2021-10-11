package components;

class NodeComp 
{
    public var neighbors:Array<NodeComp>;
    public var parentNode:NodeComp;
    public var occupant:echoes.Entity;
    public var g:Int;
    public var modifier:Int;
    public var heiristic:Int;
    public var nodeX:Int;
    public var nodeY:Int;
    public var x:Float;
    public var y:Float;
    public var width:Int;
    public var height:Int;
    public var frame:Int;
    public var removeShadow:Bool;
    public var canSeeOver:Bool;
    public var shadowHasBeenRemoved:Bool;
    /**
    * Resources, unlike units should be considered impassible vs temporary blocks
    */
    public var hasResource:Bool;
    /**
    * Concrete var for setting passibility. Once set, actors shouldn't be able to ever tread over it. 
    * Use for say the invisble border around the edge of the map, or indestructable walls
    */
    public var isPassable:Bool;
            
}