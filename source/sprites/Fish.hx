package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;

class Fish extends FlxSprite {

	private var group:FlxGroup;

	public function new(group:FlxGroup, xvel:Float, yvel:Float) {
		super();
		this.group = group;
		loadFishGraphic();
		velocity.x = xvel + FlxG.random.float(-2, 2);
		velocity.y = yvel + FlxG.random.float(-0.5, 0.5);
		animation.play((velocity.x < 0) ? "left" : "right");
	}

	function loadFishGraphic():Void {
		loadGraphic("graphics/fish.png", true, 32, 32);
		animation.add("right", [0, 1, 2, 3, 2, 1, 0], 3);
		animation.add("left", [4, 5, 6, 7, 6, 5, 4], 3);
	}

	public function hit(player:Player):Void {
		player.fish();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		stayInTheWater();
		wrapAround();
	}

	private function stayInTheWater():Void {
		if (y < FlxG.height / 2) {
			velocity.y = Math.abs(velocity.y);
		} else if(y + height > FlxG.height) {
			velocity.y = -Math.abs(velocity.y);
		}
	}

	private function wrapAround():Void {
		if (x > FlxG.width) {
			x -= FlxG.width + width;
		}
		if (x + width < 0) {
			x += FlxG.width + width;
		}
	}

}