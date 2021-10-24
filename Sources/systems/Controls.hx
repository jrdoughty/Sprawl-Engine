package systems;
import components.*;
import components.core.*;
import systems.core.Mouse;
import kha.input.Keyboard;
import kha.input.KeyCode;
import echoes.View;
import echoes.Entity;

class Controls extends echoes.System
{
	public static inline final speed:Int = 3;
    
    var unitView:View<Unit, Position>;

    public function new() {}
	@u public function updateK(p:Entity, pos:Position, playComp:Player, k:KeyboardComp, s:Scale, ac:AnimComp, ad:AnimData)
	{
		playComp.framesUntil--;

		if(playComp.framesUntil<=0 && (k.keysHeld[KeyCode.Up] || k.keysHeld[KeyCode.W]))
		{
			pos.y -= speed;
			if(ac.idKey == 'idle')
			{
				p.remove(AnimComp);
				p.add(ad.get('run'));
			}
		}
		else if(playComp.framesUntil<=0 && (k.keysHeld[KeyCode.Down] || k.keysHeld[KeyCode.S]))
		{
			pos.y += speed;
			if(ac.idKey == 'idle')
			{
				p.remove(AnimComp);
				p.add(ad.get('run'));
			}
		}
		else if(playComp.framesUntil<=0 && (ac.idKey != 'idle'))
		{
			p.remove(AnimComp);
			p.add(ad.get('idle'));//will remain idle if right or left aren't touched
		}

		if(playComp.framesUntil<=0 && (k.keysHeld[KeyCode.Left] || k.keysHeld[KeyCode.A]))
		{
			pos.x -= speed;
			s.x = -1;
			p.remove(AnimComp);
			p.add(ad.get('run'));
			if(ac.idKey == 'idle')
			{
				p.remove(AnimComp);
				p.add(ad.get('run'));
			}
		}
		else if(playComp.framesUntil<=0 && (k.keysHeld[KeyCode.Right] || k.keysHeld[KeyCode.D]))
		{
			pos.x += speed;
			s.x = 1;
			if(ac.idKey == 'idle')
			{
				p.remove(AnimComp);
				p.add(ad.get('run'));
			}
		}		
	}

	@u public function updateM(e:Entity, pos:Position, p:Player, m:MouseComp, ac:AnimComp, ad:AnimData, s:Scale)
		{		
			if(Mouse.isPressed(0,m))
			{
				for(i in unitView.entities)
				{
					if(Utils.getDistanceByPosition(i.get(Position),pos) < 128 && i.get(Unit).framesUntil>0 && i.get(TargetPosition) == null)
					{
						i.get(Position).x = pos.x;
						i.get(Position).y = pos.y;
						var t = new TargetPosition(Math.round(m.x),Math.round(m.y));
						if(t.y > Main.PLAYAREAHEIGHT)
						{
							t.y = Main.PLAYAREAHEIGHT;
						}
						i.get(Unit).framesUntil = Math.round(Utils.getDistanceByPosition(pos,cast(t,Position))); 
						i.add(t);
						i.add(i.get(AnimData).get('thrown'));
						p.framesUntil = 15;
						e.add(ad.get('throw'));
						s.x = (pos.x<t.x?1:-1);
						if(i.get(TargetPosition).x < i.get(Position).x && i.get(Scale).x > 0 || i.get(TargetPosition).x > i.get(Position).x && i.get(Scale).x < 0)
						{
							i.get(Scale).x *= -1;
						} 
						break;
					}
					else 
					{
						//trace(Utils.getDistanceByPosition(i.get(Position),pos));
						//trace(i.get(Unit).framesUntil);
					}
				}
			}
		}
		@u public function updateByBounds(pos:Position, p:Player)
			{		
				if(pos.y > Main.PLAYAREAHEIGHT)
					pos.y = Main.PLAYAREAHEIGHT;
				
				if(pos.x > Main.WIDTH)
					pos.x = Main.WIDTH;
				if(pos.y < 0)
					pos.y = 0;
				
				if(pos.x < 0)
					pos.x = 0;
				
			}
}