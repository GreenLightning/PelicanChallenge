package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import states.PlayState;

class CloudGroup extends FlxTypedGroup<Cloud> {

	public function new(?data:Array<CloudData>) {
		super();
		if (data != null) {
			setData(data);
		} else {
			spawnClouds(5);
		}
		startTimer();
	}

	public function setData(data:Array<CloudData>):Void {
		clear();
		for (element in data) {
			add(new Cloud(this, element));
		}
	}

	public function getData():Array<CloudData> {
		var data = new Array<CloudData>();
		forEachAlive(function(cloud:Cloud):Void {
			data.insert(0, cloud.getData());
		});
		return data;
	}

	private function spawn(?timer:FlxTimer):Void {
		spawnClouds(2);
		if (active) {
			startTimer();
		}
	}

	private function spawnClouds(count:Int):Void {
		if (count > 0) {
			for(i in 0 ... count - 1) {
				add(new Cloud(this));
			}
		}
	}

	private function startTimer():Void {
		new FlxTimer(FlxRandom.floatRanged(2.5, 7.5), spawn);
	}

}