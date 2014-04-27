package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import sprites.World;
import sprites.WorldData;
import sprites.FishGroup;
import sprites.JellyfishGroup;
import sprites.Player;
import sprites.UI;
import sprites.CloudGroup;

enum TutorialState {
	OFF;
	MOVEMENT;
	FISH_SCORE;
	FISH_TIME;
}

class PlayState extends FlxState {

	public var tutorialState:TutorialState;

	public var fish:FishGroup;
	public var jellyfish:JellyfishGroup;
	public var player:Player;
	public var ui:UI;

	private var worldData:WorldData;
	private var world:World;

	public function new(?worldData:WorldData, tutorial:Bool = false) {
		super();
		this.tutorialState = (tutorial) ? MOVEMENT : OFF;
		this.worldData = worldData;
	}
	
	override public function create():Void {
		super.create();
		world = new World(worldData);
		world.hideSun();
		add(world);

		fish = new FishGroup(this);
		add(fish);

		jellyfish = new JellyfishGroup(this);
		add(jellyfish);

		player = new Player(this);
		add(player);

		ui = new UI(this, tutorialState != OFF);
		add(ui);

		applyTutorialState();
	}

	override public function update():Void {
		super.update();
		if (player.time <= 0) {
			FlxG.switchState(new GameOverState(world.getData(worldData), player.score));
		}
		if (FlxG.keys.justPressed.ENTER) {
			var previous = tutorialState;
			switch (tutorialState) {
				case MOVEMENT:
					tutorialState = FISH_SCORE;
				case FISH_SCORE:
					tutorialState = FISH_TIME;
				case FISH_TIME:
					tutorialState = OFF;
				case OFF:
			}
			if (tutorialState != previous) {
				applyTutorialState();
			}
		}
	}

	private function applyTutorialState():Void {
		ui.applyTutorialState(tutorialState);
		if (tutorialState == OFF) {
			fish.startSpawning();
			jellyfish.startSpawning();
		}
	}
	
}