package states;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import sprites.World;
import sprites.WorldData;
import flixel.util.FlxTimer;

class GameOverState extends FlxState {

	private var worldData:WorldData;
	private var world:World;
	private var score:Int;

	private var informations = ["@MGreenLightning", "greenlightning.eu", "Ludum Dare rocks!"];
	private var infoIndex = 0;
	private var infoText:FlxText;

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

		infoText = new FlxText(10, FlxG.height, Std.int(FlxG.width / 2 - 10), informations[infoIndex], 24);
		add(infoText);
		FlxTween.tween(infoText, { y:(FlxG.height - 40) }, 0.4, { startDelay:0.5, ease:FlxEase.quadOut, complete:infoVisible });

		var menu = new FlxText(FlxG.width / 2, FlxG.height, Std.int(FlxG.width / 2 - 10), "ENTER for MENU", 24);
		menu.alignment = "right";
		add(menu);
		FlxTween.tween(menu, { y:(FlxG.height - 40) }, 0.4, { startDelay:0.7, ease:FlxEase.quadOut });
	}

	private function infoVisible(tween:FlxTween):Void {
		new FlxTimer(3, hideInfo);
	}

	private function hideInfo(timer:FlxTimer):Void {
		FlxTween.tween(infoText, { alpha:0 }, 0.4, { complete:infoHidden });
	}

	private function infoHidden(tween:FlxTween):Void {
		infoIndex = (infoIndex + 1) % informations.length;
		infoText.text = informations[infoIndex];
		FlxTween.tween(infoText, { alpha:1 }, 0.4, { complete:infoVisible });
	}


	override public function update():Void {
		super.update();
		if (FlxG.keys.justPressed.ENTER) {
			FlxG.switchState(new MenuState(world.getData(worldData)));
		}
	}

}