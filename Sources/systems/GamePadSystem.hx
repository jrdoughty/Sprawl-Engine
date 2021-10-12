package systems;

import components.GamePad;

class GamePadSystem extends echoes.System
{
    
	function new()
        {         
    
            for (i in 0...4)
            {
                if (kha.input.Gamepad.get(i) != null)
                {
                    var gamePad = new GamePad(i);
                    var khaGamePad = kha.input.Gamepad.get(i);
    
                    if (khaGamePad != null)
                    {
                        khaGamePad.notify(function(axis:Int, value:Float){onGamepadAxis(axis,value,gamePad);}, function(button:Int, value:Float){onGamepadAxis(button,value,gamePad);});
                        gamePad.active = true;
                    }
                    else
                        gamePad.active = false;
                }
            }
        }
        @u function update(g:GamePad):Void
        {
            for (key in g.buttonsUp.keys())
                g.buttonsUp.remove(key);
    
            for (key in g.buttonsPressed.keys())
                g.buttonsPressed.remove(key);
    
            g.buttonsJustPressed = false;
        }
    
        @r public function reset(g:GamePad):Void
        {
            for (key in g.buttonsUp.keys())
                g.buttonsUp.remove(key);
    
            for (key in g.buttonsPressed.keys())
                g.buttonsPressed.remove(key);
    
            for (key in g.buttonsHeld.keys())
                g.buttonsHeld.remove(key);
        }
    
        function onGamepadAxis(axis:Int, value:Float, g:GamePad):Void 
        {
            if(value < 0.1 && value > -0.1)
                value = 0;
    
            if (axis == 0)
                g.leftAnalog.x = value;
            else if (axis == 1)
                g.leftAnalog.y = value;
            else if (axis == 2)
                g.rightAnalog.x = value;
            else if (axis == 3)
                g.rightAnalog.y = value;
            else if (axis == 2)
                g.leftTrigger = value;
            else if (axis == 5)
                g.rightTrigger = value;
            else if (axis == 6) //Dpad comes in as an axis vs a button even though it only is -1, 0, or 1
            {
                if (value > 0)			
                    onGamepadButton(GamePad.DRIGHT, 1, g);
                else if (value < 0)			
                    onGamepadButton(GamePad.DLEFT, 1, g);			
                else
                {
                    onGamepadButton(GamePad.DLEFT, 0, g);
                    onGamepadButton(GamePad.DRIGHT, 0, g);
                }
            }
            else if (axis == 7)
            {
                if (value > 0)			
                    onGamepadButton(GamePad.DUP, 1, g);
                else if (value < 0)			
                    onGamepadButton(GamePad.DDOWN, 1, g);			
                else
                {
                    onGamepadButton(GamePad.DUP, 0, g);
                    onGamepadButton(GamePad.DDOWN, 0, g);
                }
            }	
        }
        
        function onGamepadButton(button:Int, value:Float, g:GamePad):Void 
        {
            if (value > 0)
            {
                g.buttonsJustPressed = true;
                g.buttonsPressed.set(button, true);
                g.buttonsHeld.set(button, true);
            }
            else
            {
                g.buttonsHeld.set(button, false);
                g.buttonsUp.set(button, true);
            }
        }
}