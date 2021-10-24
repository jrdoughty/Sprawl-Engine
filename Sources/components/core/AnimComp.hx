package components.core;

import haxe.ds.StringMap;

class AnimComp  implements hxbit.Serializable {
	@:s public var indices: Array<Int>;
	@:s public var speeddiv: Int;
	@:s public var count: Int;
	@:s public var index: Int;
	@:s public var idKey: String;
	
	
	public function new(indices: Array<Int>, speeddiv: Int, idKey:String = "") {
		this.indices = indices;
		index = 0;
        count = 0;
		this.speeddiv = speeddiv;
		this.idKey = idKey;
	}
    
	public static function createAnimData(index: Int, idKey:String = "") {
		var indices = [index];
		return new AnimComp(indices, 1, idKey);
	}
	
	public static function createAnimDataRange(minindex: Int, maxindex: Int, speeddiv: Int, idKey:String = ""): AnimComp {
		var indices = new Array<Int>();
		for (i in 0...maxindex - minindex + 1) indices.push(minindex + i);
		return new AnimComp(indices, speeddiv, idKey);
	}
}


