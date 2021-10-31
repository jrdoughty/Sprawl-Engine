package components.core;

import hxbit.Serializable;
import kha.Font;
import kha.Color;
import kha.Assets;

class TextComp implements Serializable{

    @:s public var text:String;
    @:s public var color:Color;
    @:s public var font:String;

    public function new(t:String,f:String = 'OpenSans',c:Color = Color.White) {
        font = f;
        text = t;
        color = c;
    }
}


    