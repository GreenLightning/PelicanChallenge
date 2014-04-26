import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

enum PlayerState {
	Gliding;
	DiveStart;
	DiveUnderWater;
	DiveEnd;
}

class Player extends FlxSprite {

	private static inline var MOVE_SPEED = 300;
	private static inline var DIVE_SPEED = 400;

	private var parent:PlayState;
	private var state:PlayerState = Gliding;

	public function new(parent:PlayState) {
		super();
		this.parent = parent;
		loadGraphic("graphics/pelican.png", true, false, 32, 32);
		animation.add("glide-right", [1, 2, 3], 5, true);
		animation.add("glide-left", [5, 6, 7], 5, true);
		animation.add("dive-right", [0]);
		animation.add("dive-left", [4]);
		animation.play("glide-right");
		x = 320 - width / 2;
		y = 160 - height / 2;
		velocity.x = 50;
		maxVelocity.x = 600;
		maxVelocity.y = 600;
	}

	override public function update():Void {
		super.update();
		move();
		applyState();
		animate();
		wrapAround();
	}

	private function move():Void {
		if (FlxG.keys.pressed.LEFT) {
			acceleration.x = -MOVE_SPEED;
		} else if (FlxG.keys.pressed.RIGHT) {
			acceleration.x = MOVE_SPEED;
		} else {
			acceleration.x = 0;
		}
	}

	private function applyState():Void {
		switch (state) {
			case Gliding:
				if (FlxG.keys.justPressed.SPACE) {
					state = DiveStart;
					acceleration.y = DIVE_SPEED;
				}
			case DiveStart:
				if (y > FlxG.height / 2) {
					state = DiveUnderWater;
					acceleration.y = -DIVE_SPEED;
				}
			case DiveUnderWater:
				if(y < FlxG.height / 2) {
					state = DiveEnd;
					acceleration.y = DIVE_SPEED;
				}
			case DiveEnd:
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
		if (x - width / 2 < 0) {
			x += FlxG.width;
		}
	}

}