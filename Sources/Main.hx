package;

import js.html.DOMImplementation;
import kha.System;
import kha.Assets;
import kha.Scheduler;
import echoes.Workflow;
import components.*;
import systems.*;

class Main 
{
	public static var WIDTH = 900;
	public static var HEIGHT = 900;
	public static var PLAYAREAHEIGHT = 666;
	public static function main() {
		System.start({
			title:"RTS",
			width:WIDTH,
			height:HEIGHT
		},
		function(_){
			Assets.loadEverything(function()
			{	
				new Project();
			});
		});
	}
}
