package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		//addChild(new FlxGame(256, 240, PlayState,1,60,60,true));
		addChild(new FlxGame(256, 240, Splash,1,60,60,true));
	}
}