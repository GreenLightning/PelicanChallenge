package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import sprites.World;
import sprites.FishGroup;
import sprites.JellyfishGroup;
import sprites.Player;
import sprites.UI;

class PlayState extends FlxState {

	public var fish:FishGroup;
	public var jellyfish:JellyfishGroup;
	public var player:Player;
	public var ui:UI;
	
	override public function create():Void {
		super.create();
		add(new World());

		fish = new FishGroup(this);
		add(fish);

		jellyfish = new JellyfishGroup(this);
		add(jellyfish);

		player = new Player(this);
		add(player);

		ui = new UI(this);
		add(ui);
	}

	override public function update():Void {
		super.update();
		if (player.time <= 0) {
			FlxG.switchState(new MenuState());
		}
	}
	
}