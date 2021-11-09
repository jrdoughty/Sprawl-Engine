package;

import kha.System;
import kha.Assets;
import kha.Scheduler;
import echoes.Workflow;
import components.*;
import systems.*;

class Main 
{
	public static var WIDTH = 900;
	public static var HEIGHT = 698;
	public static var PLAYAREAHEIGHT = 466;
	public static function main() {
		System.start({
			title:"Git Gold",
			width:WIDTH,
			height:HEIGHT
		},
		function(_){
			Assets.loadEverything(function()
			{	
				AssetRepo.init();
				new Project();
			});
		});
	}
}
