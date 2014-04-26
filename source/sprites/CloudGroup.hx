package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import states.PlayState;

class CloudGroup extends FlxGroup {

	private var parent:PlayState;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;
		spawn();
	}

	private function spawn(?timer:FlxTimer):Void {
		for(i in 0 ... 2) {
			add(new Cloud(this));
		}
		new FlxTimer(FlxRandom.floatRanged(3, 8), spawn);
	}

}