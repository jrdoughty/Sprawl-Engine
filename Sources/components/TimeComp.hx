package components;

import haxe.Timer;
import haxe.ds.StringMap;

@:forward
abstract TimeComp(StringMap<TimeData>)
{
	inline public function new(sm:StringMap<TimeData>) {
		this = sm;
	  }
}