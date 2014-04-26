import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;

class Fish extends FlxSprite {

	private var group:FlxGroup;

	public function new(group:FlxGroup) {
		super();
		this.group = group;
		loadGraphic("graphics/fish.png", true, false, 32, 32);
		animation.add("right", [0]);
		animation.add("left", [1]);
		velocity.x = FlxRandom.floatRanged(-40, 40);
		velocity.y = FlxRandom.floatRanged(-5, 5);
		animation.play((velocity.x < 0) ? "left" : "right");
	}

	override public function update():Void {
		super.update();
		stayInTheWater();
		wrapAround();
	}

	private function stayInTheWater():Void {
		if (y < FlxG.height / 2 || y + height > FlxG.height) {
			velocity.y = -velocity.y;
		}
	}

	private function wrapAround():Void {
		if (x + width / 2 > FlxG.width) {
			x -= FlxG.width;
		}
		if (x - width / 2 < 0) {
			x += FlxG.width;
		}
	}

}