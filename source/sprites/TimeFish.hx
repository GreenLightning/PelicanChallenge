package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;

class TimeFish extends Fish {

	public function new(group:FlxGroup, xvel:Float, yvel:Float) {
		super(group, xvel, yvel);
	}

	override function loadFishGraphic():Void {
		loadGraphic("graphics/fish_time.png", true, 32, 32);
	}

	override function applyBonus(player:Player):Void {
		player.time += 5;
	}

}