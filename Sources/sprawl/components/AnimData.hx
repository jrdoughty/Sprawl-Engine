package sprawl.components;

import haxe.ds.StringMap;

@:forward
abstract AnimData(StringMap<AnimComp>) from StringMap<AnimComp> to StringMap<AnimComp> 
{
	inline public function new(sm:StringMap<AnimComp>) {
		this = sm;
	  }
}