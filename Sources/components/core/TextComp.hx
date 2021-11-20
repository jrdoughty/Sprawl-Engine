package components.core;

import hxbit.Serializable;

class TextComp implements Serializable{

    @:s public var text:String;
    @:s public var color:Int;
    @:s public var font:String;

    public function new(t:String,f:String = 'OpenSans',c:Int = kha.Color.White) {
        font = f;
        text = t;
        color = c;
    }
}


    