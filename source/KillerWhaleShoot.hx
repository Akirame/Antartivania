package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Yope
 */
class KillerWhaleShoot extends FlxSprite 
{
	private var damage:Int;
	private var random:FlxRandom = new FlxRandom();
	private var direction:Int;

	public function new(?X:Float=0, ?Y:Float=0, ?dir:Int=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.killerShoot__png, true, 8, 8);
		animation.add("idle", [0, 1, 2, 3], 6, true);
		damage = 30;
		direction = dir;
		velocity.x = direction*random.int(100, 200);
		velocity.y = random.int(20, 60);
		animation.play("idle");
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(this, Global.player, attackPlayer);
		checkBoundaries();
	}
	
	private function attackPlayer(s:KillerWhaleShoot,p:Player):Void
	{
		p.takeDamage(damage);
		s.destroy();
	}
	
	private function checkBoundaries():Void
	{
		if (x < 0 || x > FlxG.camera.scroll.x + FlxG.camera.width)
			destroy();
	}
	
}