package states;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

class MenuState extends FlxState {

	override public function create():Void {
		super.create();
		var bg = new FlxSprite();
		bg.loadGraphic("graphics/title.png");
		add(bg);
		var title = new FlxText(32, FlxG.height / 2, Std.int(FlxG.width / 2), "Pelican\nChallenge", 64);
		title.y = FlxG.height * 0.75 - title.size;
		add(title);
		var pelican = new FlxSprite();
		pelican.loadGraphic("graphics/pelican.png", true, false, 32, 32);
		pelican.animation.add("wait", [2]);
		pelican.animation.add("fly", [2, 3, 1], 5, true);
		pelican.animation.play("wait");
		pelican.scale.x = 8;
		pelican.scale.y = 8;
		pelican.x = FlxG.width * 0.75;
		pelican.y = FlxG.height * 0.75;
		add(pelican);
	}

	override public function update():Void {
		super.update();
		if (FlxG.keys.justPressed.ENTER) {
			FlxG.switchState(new PlayState());
		}
	}

}