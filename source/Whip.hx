package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class Whip extends FlxSprite 
{
	private var damage:Int;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 4, 0xFFFFFF00);	
		damage = 1;
		pixelPerfectPosition = false;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(this, Global.enemyGroup, attackEnemy);
		FlxG.overlap(this, Global.tileGroup, attackUpgrade);
	}

	public function changePosition():Void 
	{
		if (Global.player.get_direction()==1)
			setPosition(Global.player.x + Global.player.width, Global.player.y);
		else if (Global.player.get_direction() == -1)
			setPosition(Global.player.x - width, Global.player.y);
	}	

	function attackUpgrade(a:Whip,t:Tile):Void
	{
		
		trace("culito");
		if (t.getTipo() == Tile.Tipo.UPGRADE)
		{
			t.addFish();
		}
	}
	
	private function attackEnemy(a:Whip,e:Enemy):Void
	{
		e.attack(damage);
	}
}