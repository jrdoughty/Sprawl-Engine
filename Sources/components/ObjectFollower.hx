package components;

class ObjectFollower {
    
    public var id:Int;
    public var followSpeed:Float;

    public function new(id:Int, followSpeed:Float) {
        this.id = id == -1 ? Std.random(1000000) : id;
        this.followSpeed = followSpeed;
    }
}