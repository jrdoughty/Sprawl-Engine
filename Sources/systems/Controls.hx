package systems;
import components.Position;
import components.Player;
import components.GamePad;
import components.KeyboardComp;
import components.MouseComp;
import systems.Mouse;
import kha.input.Keyboard;
import kha.input.KeyCode;
import kha.input.Mouse;

class Controls extends echoes.System
{
	public static inline final speed:Int = 3;
    
    public function new() {}
	@u public function updateK(pos:Position, p:Player, k:KeyboardComp)
	{
		if(k.keysHeld[KeyCode.Up] || k.keysHeld[KeyCode.W])
		{
			pos.y -= speed;
		}
		else if(k.keysHeld[KeyCode.Down] || k.keysHeld[KeyCode.S])
		{
			pos.y += speed;
		}

		if(k.keysHeld[KeyCode.Left] || k.keysHeld[KeyCode.A])
		{
			pos.x -= speed;
		}
		else if(k.keysHeld[KeyCode.Right] || k.keysHeld[KeyCode.D])
		{
			pos.x += speed;
		}		
	}

	@u public function updateM(pos:Position, p:Player, m:MouseComp)
		{		
			if(Mouse.isHeld(0,m))
			{
				var diffX = m.x - pos.x;
				var diffY = m.y - pos.y;
	
				if(Math.abs(diffX) > speed)
				{
					if(diffX < 0)
					{
						pos.x -= speed;
					}
					else
					{
						pos.x += speed;
					}
				}
				else
				{
					pos.x += diffX;
				}
	
				if(Math.abs(diffY) > speed)
				{
					if(diffY < 0)
					{
						pos.y -= speed;
					}
					else
					{
						pos.y += speed;
					}
				}
				else
				{
					pos.y += diffY;
				}
			}
		}
	
}