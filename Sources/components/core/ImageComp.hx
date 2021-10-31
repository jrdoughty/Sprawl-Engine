package components.core;

import hxbit.Serializable;

class ImageComp implements Serializable{
    
    @:s public var name:String;

    public function new(s:String) {
        name = s;
    }
}