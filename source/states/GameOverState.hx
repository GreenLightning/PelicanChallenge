package states;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import sprites.World;
import sprites.WorldData;

class GameOverState extends FlxState {

	private var worldData:WorldData;
	private var world:World;
	private var score:Int;

	public function new(?worldData:WorldData, score:Int) {
		super();
		this.worldData = worldData;
		this.score = score;
	}

	override public function create():Void {
		super.create();
		world = new World(worldData);
		world.showSun();
		add(world);
		var scoreText = new FlxText(32, 0, Std.int(FlxG.width / 2), "Score: " + score, 64);
		scoreText.y = FlxG.height * 0.75 - scoreText.size / 2;
		add(scoreText);
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
		var menu = new FlxText(FlxG.width / 2, FlxG.height, Std.int(FlxG.width / 2 - 10), "ENTER for MENU", 24);
		menu.alignment = "right";
		add(menu);
		FlxTween.tween(menu, { y:(FlxG.height - 40) }, 0.4, { startDelay:0.5, ease:FlxEase.quadOut });
	}

	override public function update():Void {
		super.update();
		if (FlxG.keys.justPressed.ENTER) {
			FlxG.switchState(new MenuState(world.getData(worldData)));
		}
	}

}