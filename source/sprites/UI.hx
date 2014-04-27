package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import states.PlayState;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class UI extends FlxGroup {

	private static inline var FISH_SCALE:Float = 7.5;
	private static inline var BIG_FISH_SCALE:Float = FISH_SCALE * 0.5;
	private static inline var JELLYFISH_SCALE:Float = FISH_SCALE * 0.7;
	private static inline var TIME_FISH_SCALE:Float = FISH_SCALE;


	private var parent:PlayState;

	private var score:FlxText;
	private var time:FlxText;

	private var movement:FlxText;

	private var fishText:FlxText;
	private var fish:FlxSprite;
	private var bigFish:FlxSprite;
	private var fishScoreText:FlxText;
	private var bigFishScoreText:FlxText;

	private var otherFishText:FlxText;
	private var jellyfish:FlxSprite;
	private var timeFish:FlxSprite;
	private var jellyfishText:FlxText;
	private var timeFishText:FlxText;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;

		score = new FlxText(5, 5, Std.int(FlxG.width / 2 - 5), "Score: 0", 24);
		score.alpha = 0;
		add(score);

		time = new FlxText(FlxG.width / 2, 5, Std.int(FlxG.width / 2 - 5), "Time: 60", 24);
		time.alignment = "right";
		time.alpha = 0;
		add(time);

		movement = new FlxText(20, FlxG.height * 0.55, FlxG.width - 40, "ARROW KEYS -> MOVE\nSPACE -> DIVE\nENTER -> NEXT", 64);
		movement.alpha = 0;
		add(movement);

		fishText = new FlxText(FlxG.width, FlxG.height / 2, FlxG.width, "FISH -> SCORE", 48);
		fishText.alignment = "center";
		add(fishText);

		fish = new FlxSprite();
		fish.loadGraphic("graphics/fish.png", true, 32, 32);
		fish.animation.add("anim", [0]);
		fish.animation.play("anim");
		fish.scale.x = FISH_SCALE;
		fish.scale.y = FISH_SCALE;
		fish.x = FlxG.width * 0.25 + FlxG.width;
		fish.y = FlxG.height * 0.725;
		add(fish);

		bigFish = new FlxSprite();
		bigFish.loadGraphic("graphics/fish_big.png", true, 64, 64);
		bigFish.animation.add("anim", [1]);
		bigFish.animation.play("anim");
		bigFish.scale.x = BIG_FISH_SCALE;
		bigFish.scale.y = BIG_FISH_SCALE;
		bigFish.x = FlxG.width * 0.75 + FlxG.width;
		bigFish.y = FlxG.height * 0.675;
		add(bigFish);

		fishScoreText = new FlxText(FlxG.width, FlxG.height * 0.9, FlxG.width / 2, "+1", 48);
		fishScoreText.alignment = "center";
		add(fishScoreText);

		bigFishScoreText = new FlxText(FlxG.width / 2 + FlxG.width, FlxG.height * 0.9, FlxG.width / 2, "+2", 48);
		bigFishScoreText.alignment = "center";
		add(bigFishScoreText);

		otherFishText = new FlxText(FlxG.width, FlxG.height / 2, FlxG.width, "OTHER FISH -> TIME", 48);
		otherFishText.alignment = "center";
		add(otherFishText);

		jellyfish = new FlxSprite();
		jellyfish.loadGraphic("graphics/jellyfish.png");
		jellyfish.scale.x = JELLYFISH_SCALE;
		jellyfish.scale.y = JELLYFISH_SCALE;
		jellyfish.x = FlxG.width * 0.25 + FlxG.width;
		jellyfish.y = FlxG.height * 0.75;
		add(jellyfish);

		timeFish = new FlxSprite();
		timeFish.loadGraphic("graphics/fish_time.png", true, 32, 32);
		timeFish.animation.add("anim", [1]);
		timeFish.animation.play("anim");
		timeFish.scale.x = TIME_FISH_SCALE;
		timeFish.scale.y = TIME_FISH_SCALE;
		timeFish.x = FlxG.width * 0.75 + FlxG.width;
		timeFish.y = FlxG.height * 0.75;
		add(timeFish);

		jellyfishText = new FlxText(FlxG.width, FlxG.height * 0.9, FlxG.width / 2, "-5", 48);
		jellyfishText.alignment = "center";
		add(jellyfishText);

		timeFishText = new FlxText(FlxG.width / 2 + FlxG.width, FlxG.height * 0.9, FlxG.width / 2, "+5", 48);
		timeFishText.alignment = "center";
		add(timeFishText);
	}

	public function applyTutorialState(state:TutorialState):Void {
		switch (state) {
			case MOVEMENT:
				FlxTween.tween(movement, { alpha:1 }, 0.5);
			case FISH_SCORE:
				FlxTween.tween(movement, { x:(20 - FlxG.width) }, 0.5, { ease:FlxEase.quadInOut });

				FlxTween.tween(fishText, { x:0 }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(fish, { x:(FlxG.width * 0.25) }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(bigFish, { x:(FlxG.width * 0.75) }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(fishScoreText, { x:0 }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(bigFishScoreText, { x:(FlxG.width / 2) }, 0.5, { ease:FlxEase.quadInOut });
			case FISH_TIME:
				FlxTween.tween(fishText, { x:-FlxG.width }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(fish, { x:(FlxG.width * 0.25 - FlxG.width) }, 0.5, {ease:FlxEase.quadInOut });
				FlxTween.tween(bigFish, { x:(FlxG.width * 0.75 - FlxG.width) }, 0.5, {ease:FlxEase.quadInOut });
				FlxTween.tween(fishScoreText, { x:-FlxG.width }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(bigFishScoreText, { x:(FlxG.width / 2 - FlxG.width) }, 0.5, { ease:FlxEase.quadInOut });

				FlxTween.tween(otherFishText, { x:0 }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(jellyfish, { x:(FlxG.width * 0.25) }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(timeFish, { x:(FlxG.width * 0.75) }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(jellyfishText, { x:0 }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(timeFishText, { x:(FlxG.width / 2) }, 0.5, { ease:FlxEase.quadInOut });
			case OFF:
				FlxTween.tween(otherFishText, { x:-FlxG.width }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(jellyfish, { x:(FlxG.width * 0.25 - FlxG.width) }, 0.5, {ease:FlxEase.quadInOut });
				FlxTween.tween(timeFish, { x:(FlxG.width * 0.75 - FlxG.width) }, 0.5, {ease:FlxEase.quadInOut });
				FlxTween.tween(jellyfishText, { x:-FlxG.width }, 0.5, { ease:FlxEase.quadInOut });
				FlxTween.tween(timeFishText, { x:(FlxG.width / 2 - FlxG.width) }, 0.5, { ease:FlxEase.quadInOut });

				FlxTween.tween(score, { alpha:1 }, 0.5);
				FlxTween.tween(time, { alpha:1 }, 0.5);
		}
	}

	override public function update():Void {
		super.update();
		score.text = "Score: " + parent.player.score;
		time.text = "Time: " + Std.int(parent.player.time);
	}

}