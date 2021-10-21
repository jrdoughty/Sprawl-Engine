package components;

class ButtonComp {

    public var tag:String;
    public var active:Bool;
    public var over:Bool;
    public function new(t:String, a:Bool = true, o:Bool = false) {//Do I need this?
        tag = t;
        active = a;
        over = o;
    }

}