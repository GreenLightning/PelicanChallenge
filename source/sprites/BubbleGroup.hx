package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import states.PlayState;

class BubbleGroup extends FlxTypedGroup<Bubble> {

	public function new(?data:Array<BubbleData>) {
		super();
		if (data != null) {
			setData(data);
		} else {
			spawnBubbles(10);
		}
		startTimer();
	}

	public function setData(data:Array<BubbleData>):Void {
		clear();
		for (element in data) {
			add(new Bubble(this, element));
		}
	}

	public function getData():Array<BubbleData> {
		var data = new Array<BubbleData>();
		forEachAlive(function(bubble:Bubble):Void {
			data.insert(0, bubble.getData());
		});
		return data;
	}

	private function spawn(?timer:FlxTimer):Void {
		spawnBubbles(2);
		if (active) {
			startTimer();
		}
	}

	private function spawnBubbles(count:Int):Void {
		if (count > 0) {
			for(i in 0 ... count - 1) {
				add(new Bubble(this));
			}
		}
	}

	private function startTimer():Void {
		new FlxTimer().start(FlxG.random.float(0.5, 1.0), spawn);
	}

}