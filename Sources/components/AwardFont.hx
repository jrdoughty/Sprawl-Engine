package components;

class AwardFont {
    public var value:String;
    public var fontSize:Int; 
    public var r:Int = 0;
    public var b:Int = 0;
    public var g:Int = 0;
    public function new(v:String,fs:Int = 20) {
        value = v;
        fontSize = fs;
    }
}