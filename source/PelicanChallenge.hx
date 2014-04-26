import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;

class PelicanChallenge extends Sprite {
	
	static public function main():Void {	
		Lib.current.addChild(new PelicanChallenge());
	}
	
	public function new() {
		super();
		if (stage != null) {
			initialize();
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		initialize();
	}
	
	private function initialize():Void {
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		var game:FlxGame = new PelicanChallengeGame();
		addChild(game);
	}
	
}