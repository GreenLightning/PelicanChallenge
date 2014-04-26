package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

class Cloud extends FlxSprite {

	private var group:FlxGroup;
	private var id:Int = FlxRandom.intRanged(0, 100);

	public function new(group:FlxGroup) {
		super();
		this.group = group;
		loadGraphic("graphics/cloud_" + FlxRandom.intRanged(0, 4) + ".png");
		velocity.x = FlxRandom.sign() * FlxRandom.floatRanged(5, 20);
		x = (velocity.x < 0) ? FlxG.width : -width;
		y = FlxRandom.floatRanged(0, FlxG.height / 2 - height);
	}

	override public function update():Void {
		super.update();
		if(x + width < 0 || x > FlxG.width) {
			remove();
		}
	}

	private function remove():Void {
		kill();
		group.remove(this, true);
	}

}