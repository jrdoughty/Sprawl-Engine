package serialization;

import haxe.io.Bytes;
import hxbit.Serializable;
import echoes.Entity.Status;


class WorkflowData implements Serializable
{

    @:s public var idPool = new Array<Int>();
    @:s public var status = new Array<Status>();
    @:s public var entities = new Array<Int>();
    @:s public var comps:Array<Bytes> = [];

    public function new() {
        
    }
    
}