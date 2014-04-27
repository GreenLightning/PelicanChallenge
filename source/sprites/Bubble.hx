package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

class Bubble extends FlxSprite {

	private var group:FlxTypedGroup<Bubble>;

	public function new(group:FlxTypedGroup<Bubble>, ?data:BubbleData) {
		super();
		this.group = group;
		loadGraphic("graphics/bubble.png");
		if (data != null) {
			setData(data);
		} else {
			velocity.y = FlxRandom.floatRanged(-5, -40);
			x = FlxRandom.floatRanged(0, FlxG.width);
			y = FlxG.height;
		}
	}

	public function setData(data:BubbleData):Void {
		velocity.y = data.velocityy;
		x = data.x;
		y = data.y;
	}

	public function getData(?data:BubbleData):BubbleData {
		if (data == null) {
			data = new BubbleData();
		}
		data.velocityy = velocity.y;
		data.x = x;
		data.y = y;
		return data;
	}

	override public function update():Void {
		super.update();
		if(y < FlxG.height / 2) {
			kill();
			group.remove(this, true);
		}
	}

}