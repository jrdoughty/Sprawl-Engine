package components;
class ScoreComp  implements hxbit.Serializable 
{
    @:s public var score:Int;
    public function new(s:Int) 
    {
        score = s;   
    }
}