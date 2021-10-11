package systems;

import components.*;

class Animation extends echoes.System
{
	
	@u public inline function update(ac:AnimComp){
		ac.count++;
		if (ac.count % ac.speeddiv == 0) {
			++ac.index;
			if (ac.index >= ac.indices.length) {
				ac.index = 0;
			}
		}
	}
}




