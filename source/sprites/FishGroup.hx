package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import states.PlayState;

class FishGroup extends FlxGroup {

	private var parent:PlayState;
	private var toSpawn:Array<Fish>;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;
		toSpawn = [];
	}

	public function startSpawning():Void {
		spawnNormal();
		spawnBig();
		spawnTime();
	}

	private function spawnNormal(?timer:FlxTimer):Void {
		if (countLiving() + toSpawn.length < 30) {
			spawnGroup();
		}
		new FlxTimer().start(FlxG.random.float(1, 4), spawnNormal);
	}

	private function spawnGroup():Void {
		var startX = FlxG.random.float(0, FlxG.width);
		var endX = startX + FlxG.random.float(FlxG.width / 8, FlxG.width / 2);
		var middleX = (startX + endX) / 2;
		var upperY = FlxG.height / 2 + FlxG.random.float(0, FlxG.height * 0.2);
		var lowerY = FlxG.height - FlxG.random.float(0, FlxG.height * 0.2);
		var xvel = FlxG.random.float(-40, 40);
		var yvel = FlxG.random.float(-5, 5);
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
		toSpawn.push(fish);
	}

	private function spawnBig(?timer:FlxTimer):Void {
		var fish = new BigFish(this, FlxG.random.float(-60, 60), FlxG.random.float(-8, 8));
		fish.x = FlxG.random.float(0, FlxG.width);
		fish.y = FlxG.random.float(FlxG.height * 0.6, FlxG.height);
		add(fish);
		new FlxTimer().start(FlxG.random.float(2, 18), spawnBig);
	}

	private function spawnTime(?timer:FlxTimer):Void {
		var fish = new TimeFish(this, FlxG.random.float(-30, 30), FlxG.random.float(-10, 10));
		fish.x = FlxG.random.float(0, FlxG.width);
		fish.y = FlxG.random.float(FlxG.height * 0.75, FlxG.height);
		add(fish);
		new FlxTimer().start(FlxG.random.float(5.0, 25.0), spawnTime);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (toSpawn.length > 0) {
			add(toSpawn.shift());
		}
		FlxG.overlap(parent.player, this, onOverlap, testOverlap);
	}

	private function testOverlap(sprite1:FlxSprite, sprite2:FlxSprite):Bool {
		return FlxG.pixelPerfectOverlap(sprite1, sprite2);
	}

	private function onOverlap(player:Player, fish:Fish) {
		fish.hit(player);
		fish.kill();
		remove(fish, true);
	}

}