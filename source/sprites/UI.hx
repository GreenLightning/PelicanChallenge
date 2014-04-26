package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import states.PlayState;

class UI extends FlxGroup {

	public var parent:PlayState;

	private var score:FlxText;
	private var time:FlxText;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;

		score = new FlxText(5, 5, Std.int(FlxG.width / 2 - 5), "Score: 0", 24);
		add(score);

		time = new FlxText(FlxG.width / 2, 5, Std.int(FlxG.width / 2 - 5), "Time: 60", 24);
		time.alignment = "right";
		add(time);
	}

	override public function update():Void {
		super.update();
		score.text = "Score: " + parent.player.score;
		time.text = "Time: " + Std.int(parent.player.time);
	}

}