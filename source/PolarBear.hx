package;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Yope
 */
class PolarBear extends Enemy 
{
	private var direction:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(64, 32, 0xFFFFFFFF);
		vida = 2;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		move();
	}
	
	private function move():Void
	{
		velocity.x = direction * 50;
	}
	
	public function setDirection(dir:Int):Void
	{
		direction = dir;
	}
}