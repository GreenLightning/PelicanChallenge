import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

class FishGroup extends FlxGroup {

	private var parent:PlayState;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;
		FlxTimer.start(0.5, spawn);	
	}

	private function spawn(timer:FlxTimer):Void {
		makeFish(FlxRandom.floatRanged(0, FlxG.width), FlxRandom.floatRanged(FlxG.height / 2, FlxG.height));
		FlxTimer.start(FlxRandom.floatRanged(0.5, 1.5), spawn);
	}

	private function makeFish(x:Float, y:Float) {
		var fish = new Fish(this);
		fish.x = x;
		fish.y = y;
		add(fish);
	}

	override public function update():Void {
		super.update();
		FlxG.overlap(parent.player, this, onOverlap);
	}

	private function onOverlap(player:Player, fish:Fish) {
		fish.kill();
		remove(fish, true);
	}

}