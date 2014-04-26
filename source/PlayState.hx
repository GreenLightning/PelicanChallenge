import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState {
	
	override public function create():Void {
		super.create();
		add(new World());
		add(new FishGroup());
		add(new Player());
	}
	
	override public function destroy():Void {
		super.destroy();
	}
	
	override public function update():Void {
		super.update();
	}
	
}