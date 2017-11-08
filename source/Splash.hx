package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author ...
 */
class Splash extends FlxState 
{
	private var timer:Float = 0;
	override public function create():Void 
	{
		super.create();
		var textoTitle:FlxText = new FlxText(55, 0, 0, "ANTARTIVANIA", 16);
		var textoP1:FlxText = new FlxText(FlxG.camera.width / 2 - 10, 100, 0, "by", 10);
		var textoP2:FlxText = new FlxText(FlxG.camera.width / 2 - 50, 120, 0, "Gaston Villalba", 10);
		var textoP3:FlxText = new FlxText(FlxG.camera.width / 2 - 60, 140, 0, "Ana Belen Taborcias", 10);
		var textoP4:FlxText = new FlxText(FlxG.camera.width/2 - 50, 160, 0, "Daniel Natarelli", 10);
		add(textoTitle);
		add(textoP1);
		add(textoP2);
		add(textoP3);
		add(textoP4);
		
		textoTitle.color = 0xFF0000FF;
		FlxTween.tween(textoTitle, {y: FlxG.camera.height / 2 - 50}, 3, {ease:FlxEase.backIn, type:FlxTween.ONESHOT});
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		timer += FlxG.elapsed;
		trace(timer);
		if (timer >= 4)
		{
			timer = 0;
			FlxG.switchState(new PlayState());
		}
	}
	
}