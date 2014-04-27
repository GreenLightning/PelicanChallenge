package sprites;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;

class World extends FlxGroup {

	private var sunVisible:Bool = true;

	private var sky:FlxSprite;
	private var sun:FlxSprite;
	private var clouds:CloudGroup;
	private var water:FlxSprite;
	private var bubbles:BubbleGroup;

	public function new(?data:WorldData) {
		super();
		sky = new FlxSprite();
		sky.loadGraphic("graphics/world_sky.png");
		add(sky);
		sun = new FlxSprite();
		sun.loadGraphic("graphics/world_sun.png");
		add(sun);
		clouds = new CloudGroup();
		add(clouds);
		water = new FlxSprite();
		water.loadGraphic("graphics/world_water.png");
		add(water);
		bubbles = new BubbleGroup();
		add(bubbles);

		sun.angularVelocity = 10;

		if (data != null) {
			setData(data);
		}
	}

	public function hideSun() {
		if (sunVisible) {
			sunVisible = false;
			FlxTween.tween(sun, { alpha:0 }, 3);
		}
	}

	public function showSun() {
		if (!sunVisible) {
			sunVisible = true;
			FlxTween.tween(sun, { alpha:1 }, 3);
		}
	}

	public function setData(data:WorldData):Void {
		sunVisible = data.sunVisible;
		sun.alpha = (sunVisible) ? 1 : 0;
		sun.angle = data.sunAngle;
		clouds.setData(data.clouds);
		bubbles.setData(data.bubbles);
	}

	public function getData(?data:WorldData):WorldData {
		if (data == null) {
			data = new WorldData();
		}
		data.sunVisible = sunVisible;
		data.sunAngle = sun.angle;
		data.clouds = clouds.getData();
		data.bubbles = bubbles.getData();
		return data;
	}

}