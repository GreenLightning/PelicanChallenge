import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import states.MenuState;
import states.PlayState;

class PelicanChallengeGame extends FlxGame {
	
	var gameWidth:Int = 960;
	var gameHeight:Int = 640;
	#if debug
		var initialState:Class<FlxState> = PlayState;
	#else
		var initialState:Class<FlxState> = MenuState;
	#end
	var zoom:Float = -1;
	var framerate:Int = 60;
	var skipSplash:Bool = true;
	var startFullscreen:Bool = false;
	
	public function new() {
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		if (zoom == -1) {
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}
		super(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen);
	}
	
}