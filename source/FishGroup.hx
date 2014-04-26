import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

class FishGroup extends FlxGroup {

	public function new() {
		super();
		FlxTimer.start(0.5, spawn);	
	}

	private function spawn(timer:FlxTimer):Void {
		makeFish(FlxRandom.floatRanged(0, FlxG.width), FlxRandom.floatRanged(FlxG.height / 2, FlxG.height));
		FlxTimer.start(FlxRandom.floatRanged(0.5, 1.5), spawn);
	}

	private function makeFish(x:Float, y:Float) {
		var fish = new Fish();
		fish.x = x;
		fish.y = y;
		add(fish);
	}

}