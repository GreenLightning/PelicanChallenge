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
	}

	override function applyBonus(player:Player):Void {
		player.score += 2;
	}

}