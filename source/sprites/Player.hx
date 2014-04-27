package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import states.PlayState;

enum PlayerState {
	Gliding;
	DiveStart;
	DiveUnderWater;
	DiveEnd;
}

class Player extends FlxSprite {

	private static inline var VERTICAL_SPEED = 100;
	private static inline var HORIZONTAL_ACCELERATION = 300;
	private static inline var DIVE_ACCELERATION = 400;

	public var score:Int = 0;
	public var time:Float = 60;

	private var parent:PlayState;
	private var state:PlayerState = Gliding;

	private var eatSound:FlxSound;
	private var hitSound:FlxSound;
	private var splashSound:FlxSound;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;
		loadGraphic("graphics/pelican.png", true, 32, 32);
		animation.add("glide-right", [1, 2, 3], 5, true);
		animation.add("glide-left", [5, 6, 7], 5, true);
		animation.add("dive-right", [0]);
		animation.add("dive-left", [4]);
		animation.play("glide-right");
		x = 320 - width / 2;
		y = 160 - height / 2;
		velocity.x = 50;
		maxVelocity.x = 600;
		maxVelocity.y = 2000;
		eatSound = FlxG.sound.load("sounds/eat.wav");
		hitSound = FlxG.sound.load("sounds/hit.wav");
		splashSound = FlxG.sound.load("sounds/splash.wav");
	}

	override public function update():Void {
		super.update();
		updateTime();
		move();
		applyState();
		animate();
		wrapAround();
	}

	private function updateTime():Void {
		if (parent.tutorialState == OFF) {
			time -= FlxG.elapsed;
		}
	}

	private function move():Void {
		if (FlxG.keys.pressed.LEFT) {
			acceleration.x = -HORIZONTAL_ACCELERATION;
		} else if (FlxG.keys.pressed.RIGHT) {
			acceleration.x = HORIZONTAL_ACCELERATION;
		} else {
			acceleration.x = 0;
		}
	}

	private function applyState():Void {
		switch (state) {
			case Gliding:
				if (FlxG.keys.justPressed.SPACE || y + height > FlxG.height / 2 - 30) {
					state = DiveStart;
					velocity.y = 0;
					acceleration.y = DIVE_ACCELERATION;
				}
				if (FlxG.keys.pressed.UP) {
					velocity.y = (y < 30) ? 60 : -VERTICAL_SPEED;
				} else if (FlxG.keys.pressed.DOWN) {
					velocity.y = VERTICAL_SPEED;
				} else {
					velocity.y = (y < 30) ? 60 : 0;
				}
			case DiveStart:
				if (y + height / 2 > FlxG.height / 2) {
					splashSound.play(true);
					parent.splash.add(new Splash(parent, x));
					state = DiveUnderWater;
					acceleration.y = -DIVE_ACCELERATION;
				}
			case DiveUnderWater:
				if(y + height / 2 <= FlxG.height / 2) {
					splashSound.play(true);
					parent.splash.add(new Splash(parent, x));
					state = DiveEnd;
					acceleration.y = DIVE_ACCELERATION;
				}
			case DiveEnd:
				if (y < 30) {
					acceleration.y = 3 * DIVE_ACCELERATION;
				}
				if (y < 20) {
					acceleration.y = 9 * DIVE_ACCELERATION;
				}
				if (y < 10) {
					acceleration.y = 27 * DIVE_ACCELERATION;
				}
				if (velocity.y >= 0) {
					state = Gliding;
					angle = 0;
					velocity.y = 0;
					acceleration.y = 0;
				}
		}
	}

	private function animate():Void {
		var left = (velocity.x < 0);
		if (state != Gliding) {
			angle = Math.atan2(velocity.y, velocity.x) * 180 / Math.PI;
			if (left) {
				angle += 180;
			}
		}
		var target = (state == Gliding) ? "glide" : "dive";
		target += "-";
		target += left ? "left" : "right";
		if (animation.name != target) {
			animation.play(target);
		}
	}

	private function wrapAround():Void {
		if (x + width / 2 > FlxG.width) {
			x -= FlxG.width;
		}
		if (x + width / 2 < 0) {
			x += FlxG.width;
		}
	}

	public function eat(fish:Fish):Void {
		eatSound.play();
		if (parent.tutorialState == OFF) {
			fish.applyBonus(this);
		}
	}

	public function hit(jelly:Jellyfish):Void {
		hitSound.play();
		if (parent.tutorialState == OFF) {
			jelly.applyMalus(this);
		}
	}

}