package components;

class ButtonComp   implements hxbit.Serializable {

    @:s public var tag:String;
    @:s public var active:Bool;
    @:s public var over:Bool;
    public function new(t:String, a:Bool = true, o:Bool = false) {//Do I need this?
        tag = t;
        active = a;
        over = o;
    }

}