package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;

class TimeFish extends Fish {

	public function new(group:FlxGroup, xvel:Float, yvel:Float) {
		super(group, xvel, yvel);
	}

	override function loadFishGraphic():Void {
		loadGraphic("graphics/fish_time.png", true, 32, 32);
		animation.add("right", [0, 1, 0, 2], 5);
		animation.add("left", [3, 4, 3, 5], 5);
	}

	override function hit(player:Player):Void {
		player.timeFish();
	}

}