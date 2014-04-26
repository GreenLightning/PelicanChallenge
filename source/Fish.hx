import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxRandom;

class Fish extends FlxSprite {

	public function new() {
		super();
		loadGraphic("graphics/fish.png");
		velocity.x = FlxRandom.floatRanged(-40, 40);
		velocity.y = FlxRandom.floatRanged(-5, 5);
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