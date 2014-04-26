package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

class Jellyfish extends FlxSprite {

	private var group:FlxGroup;

	public function new(group:FlxGroup) {
		super();
		this.group = group;
		loadGraphic("graphics/jellyfish.png");
		FlxTimer.start(10, remove);
	}

	private function remove(timer:FlxTimer):Void {
		kill();
		group.remove(this, true);
	}

}