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
	public var speed:Int = 5;
    
    public function new() {
		//Keyboard.get().notify(onKeyDown, onKeyUp);
		//Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove,null);
    }
	@u public function updateG(pos:Position, p:Player, g:GamePad,k:KeyboardComp,m:MouseComp)
	{


		if(k.keysHeld[KeyCode.Up] || k.keysHeld[KeyCode.W] || g.buttonsPressed[GamePad.DUP])
		{
			pos.y -= speed;
		}
		else if(k.keysHeld[KeyCode.Down] || k.keysHeld[KeyCode.S] || g.buttonsPressed[GamePad.DDOWN])
		{
			pos.y += speed;
		}

		if(k.keysHeld[KeyCode.Left] || k.keysHeld[KeyCode.A] || g.buttonsPressed[GamePad.DLEFT])
		{
			pos.x -= speed;
		}
		else if(k.keysHeld[KeyCode.Right] || k.keysHeld[KeyCode.D] || g.buttonsPressed[GamePad.DRIGHT])
		{
			pos.x += speed;
		}

		
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