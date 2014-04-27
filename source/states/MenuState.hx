package states;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import sprites.World;
import sprites.WorldData;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class MenuState extends FlxState {

	private var worldData:WorldData;
	private var world:World;

	public function new(?worldData:WorldData) {
		super();
		this.worldData = worldData;
	}

	override public function create():Void {
		super.create();
		world = new World(worldData);
		add(world);
		var title = new FlxText(32, FlxG.height * 0.6, Std.int(FlxG.width / 2), "Pelican\nChallenge", 64);
		add(title);
		var pelican = new FlxSprite();
		pelican.loadGraphic("graphics/pelican.png", true, 32, 32);
		pelican.animation.add("wait", [2]);
		pelican.animation.add("fly", [2, 3, 1], 5, true);
		pelican.animation.play("wait");
		pelican.scale.x = 8;
		pelican.scale.y = 8;
		pelican.x = FlxG.width * 0.75;
		pelican.y = FlxG.height * 0.65;
		add(pelican);
		var tutorial = new FlxText(10, FlxG.height, Std.int(FlxG.width / 2 - 10), "T for TUTORIAL", 24);
		add(tutorial);
		FlxTween.tween(tutorial, { y:(FlxG.height - 40) }, 0.4, { startDelay:0.5, ease:FlxEase.quadOut });
		var play = new FlxText(FlxG.width / 2, FlxG.height, Std.int(FlxG.width / 2 - 10), "ENTER to PLAY", 24);
		play.alignment = "right";
		add(play);
		FlxTween.tween(play, { y:(FlxG.height - 40) }, 0.4, { startDelay:0.7, ease:FlxEase.quadOut });
	}

	override public function update():Void {
		super.update();
		if (FlxG.keys.justPressed.T) {
			FlxG.switchState(new PlayState(world.getData(worldData), true));
		} else if (FlxG.keys.justPressed.ENTER) {
			FlxG.switchState(new PlayState(world.getData(worldData)));
		}
	}

}