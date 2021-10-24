package components.core;

import haxe.ds.StringMap;

@:forward
abstract AnimData(StringMap<AnimComp>) {
	inline public function new(sm:StringMap<AnimComp>) {
		this = sm;
	  }
}