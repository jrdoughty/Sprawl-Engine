package components;

class AwardFont  implements hxbit.Serializable  {
    @:s public var value:String;
    @:s public var fontSize:Int; 
    @:s public var r:Int = 0;
    @:s public var b:Int = 0;
    @:s public var g:Int = 0;
    public function new(v:String,fs:Int = 20) {
        value = v;
        fontSize = fs;
    }
}