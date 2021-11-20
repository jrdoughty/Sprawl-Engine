package sprawl.components;

import echoes.Entity;

class NodeComp  implements hxbit.Serializable
{
    @:s public var neighbors:Array<Entity>;
    @:s public var parentNode:NodeComp;
    @:s public var occupant:echoes.Entity;
    @:s public var g:Int;
    @:s public var modifier:Int;
    @:s public var heiristic:Int;
    @:s public var nodeX:Int;
    @:s public var nodeY:Int;
    @:s public var x:Float;
    @:s public var y:Float;
    @:s public var width:Int;
    @:s public var height:Int;
    @:s public var frame:Int;
    @:s public var removeShadow:Bool;
    @:s public var canSeeOver:Bool;
    @:s public var shadowHasBeenRemoved:Bool;
    /**
    * Resources, unlike units should be considered impassible vs temporary blocks
    */
    @:s public var hasResource:Bool;
    /**
    * Concrete var for setting passibility. Once set, actors shouldn't be able to ever tread over it. 
    * Use for say the invisble border around the edge of the map, or indestructable walls
    */
    @:s public var isPassable:Bool;
            
}