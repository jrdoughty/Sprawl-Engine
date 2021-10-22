package components;

import kha.Font;
import kha.Color;
import kha.Assets;

class TextComp {

    public var text:String;
    public var color:Color;
    public var font:Font;

    public function new(t:String,f:Font = null,c:Color = Color.White) {
        if(f == null)
        {
            font = Assets.fonts._8bitlim;
        }
        else 
            font = f;
        text = t;
        color = c;
    }
}


    