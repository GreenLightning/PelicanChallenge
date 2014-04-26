package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import states.PlayState;

class JellyfishGroup extends FlxGroup {

	private var parent:PlayState;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;
		new FlxTimer(FlxRandom.floatRanged(3, 10), spawn);
	}

	private function spawn(timer:FlxTimer):Void {
		if (countLiving() < 4) {
			var jelly = new Jellyfish(this);
			jelly.x = FlxRandom.floatRanged(0, FlxG.width);
			jelly.y = FlxRandom.floatRanged(FlxG.height / 2, FlxG.height);
			add(jelly);
		}
		new FlxTimer(FlxRandom.floatRanged(3, 10), spawn);
	}

	override public function update():Void {
		super.update();
		FlxG.overlap(parent.player, this, onOverlap, testOverlap);
	}

	private function testOverlap(sprite1:FlxSprite, sprite2:FlxSprite):Bool {
		return FlxG.pixelPerfectOverlap(sprite1, sprite2);
	}

	private function onOverlap(player:Player, jelly:Jellyfish) {
		player.hit();
		jelly.kill();
		remove(jelly, true);
	}

}