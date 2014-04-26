package sprites;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;

class World extends FlxGroup {

	public function new() {
		super();
		var bg = new FlxSprite();
		bg.loadGraphic("graphics/world.png");
		add(bg);
		var overlay = new FlxSprite();
		overlay.loadGraphic("graphics/title.png");
		add(overlay);
		FlxTween.tween(overlay, { alpha:0 }, 1);
	}

}