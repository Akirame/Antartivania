package;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class WalrusTower extends Enemy 
{
	private var timerShoot:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 32, 0xFFFF00FF);
		immovable = true;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		timerShoot += elapsed;
		if (timerShoot >= 4)
		{
			shootTusk();
			timerShoot = 0;
		}
	}
	
	private function shootTusk():Void
	{
		
	}
	
}