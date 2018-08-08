package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
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
			velocity.y = FlxG.random.float(-5, -40);
			x = FlxG.random.float(0, FlxG.width);
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

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if(y < FlxG.height / 2) {
			kill();
			group.remove(this, true);
		}
	}

}