package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

class Cloud extends FlxSprite {

	private var group:FlxTypedGroup<Cloud>;
	private var graphicIndex:Int;

	public function new(group:FlxTypedGroup<Cloud>, ?data:CloudData) {
		super();
		this.group = group;
		if (data != null) {
			setData(data);
		} else {
			graphicIndex = FlxRandom.intRanged(0, 4);
			velocity.x = FlxRandom.sign() * FlxRandom.floatRanged(5, 20);
			x = (velocity.x < 0) ? FlxG.width : -width;
			y = FlxRandom.floatRanged(0, FlxG.height / 2 - height);
			loadGraphicIndex();
		}
	}

	public function setData(data:CloudData):Void {
		graphicIndex = data.graphicIndex;
		velocity.x = data.velocityx;
		x = data.x;
		y = data.y;
		loadGraphicIndex();
	}

	public function getData(?data:CloudData):CloudData {
		if (data == null) {
			data = new CloudData();
		}
		data.graphicIndex = graphicIndex;
		data.velocityx = velocity.x;
		data.x = x;
		data.y = y;
		return data;
	}

	private function loadGraphicIndex():Void {
		loadGraphic("graphics/cloud_" + graphicIndex + ".png");
	}

	override public function update():Void {
		super.update();
		if(x + width < 0 || x > FlxG.width) {
			kill();
			group.remove(this, true);
		}
	}

}