package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;

class BigFish extends Fish {

	public function new(group:FlxGroup, xvel:Float, yvel:Float) {
		super(group, xvel, yvel);
	}

	override function loadFishGraphic():Void {
		loadGraphic("graphics/fish_big.png", true, 64, 64);
		animation.add("right", [0, 1, 2, 3, 2, 1, 0], 9);
		animation.add("left", [4, 5, 6, 7, 6, 5, 4], 9);
	}

	override function hit(player:Player):Void {
		player.bigFish();
	}

}