package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import states.PlayState;

class Splash extends FlxSprite {

	private var parent:PlayState;

	public function new(parent:PlayState, x:Float) {
		super();
		this.parent = parent;
		loadGraphic("graphics/splash.png", true, 32, 32);
		animation.add("splash", [0, 1, 2], 12, false);
		animation.play("splash");
		this.x = x;
		this.y = FlxG.height / 2 - height;
		parent.splash.add(this);
		new FlxTimer().start(0.25, removeSplash);
	}

	private function removeSplash(timer:FlxTimer):Void {
		parent.splash.remove(this, true);
	}

}