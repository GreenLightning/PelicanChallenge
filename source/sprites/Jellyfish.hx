package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;

class Jellyfish extends FlxSprite {

	private var group:FlxGroup;

	public function new(group:FlxGroup) {
		super();
		this.group = group;
		loadGraphic("graphics/jellyfish.png", true, 32, 32);
		animation.add("anim", [0,1,2,3,4,5,6], 10);
		animation.play("anim");
		new FlxTimer().start(10, remove);
	}

	private function remove(timer:FlxTimer):Void {
		kill();
		group.remove(this, true);
	}

}