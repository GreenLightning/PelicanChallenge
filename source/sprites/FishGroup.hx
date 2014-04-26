package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import states.PlayState;

class FishGroup extends FlxGroup {

	private var parent:PlayState;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;
		spawn();
	}

	private function spawn(?timer:FlxTimer):Void {
		if (countLiving() < 30) {
			spawnGroup();
		}
		new FlxTimer(FlxRandom.floatRanged(1, 4), spawn);
	}

	private function spawnGroup():Void {
		var startX = FlxRandom.floatRanged(0, FlxG.width);
		var endX = startX + FlxRandom.floatRanged(FlxG.width / 8, FlxG.width / 2);
		var middleX = (startX + endX) / 2;
		var upperY = FlxG.height / 2 + FlxRandom.floatRanged(0, FlxG.height * 0.2);
		var lowerY = FlxG.height - FlxRandom.floatRanged(0, FlxG.height * 0.2);
		var xvel = FlxRandom.floatRanged(-40, 40);
		var yvel = FlxRandom.floatRanged(-5, 5);
		var xpos = startX;
		while (xpos < endX) {
			var posPercentage = (xpos - middleX) / (middleX - startX);
			var ypos = lowerY + posPercentage * posPercentage * (upperY - lowerY);
			spawnFish(xpos % FlxG.width, ypos, xvel, yvel);
			xpos += 20;
		}
	}

	private function spawnFish(x:Float, y:Float, xvel:Float, yvel:Float) {
		var fish = new Fish(this, xvel, yvel);
		fish.x = x;
		fish.y = y;
		add(fish);
	}

	override public function update():Void {
		super.update();
		FlxG.overlap(parent.player, this, onOverlap, testOverlap);
	}

	private function testOverlap(sprite1:FlxSprite, sprite2:FlxSprite):Bool {
		return FlxG.pixelPerfectOverlap(sprite1, sprite2);
	}

	private function onOverlap(player:Player, fish:Fish) {
		player.eat();
		fish.kill();
		remove(fish, true);
	}

}