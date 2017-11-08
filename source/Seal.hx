package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.tile.FlxRayCastTilemap;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author ...
 */

class Seal extends Enemy
{
	private var timerMov:Float = 0;
	private var direction:Int;
	private var derecha:FlxSprite;
	private var izquierda:FlxSprite;
	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.seal__png, true,64,32);	
		acceleration.y = 1400;
		animation.add("walk", [0, 1],6, true);
		derecha = new FlxSprite(x + width, y + height);
		derecha.makeGraphic(2, 32, 0xFFFF0000);
		izquierda = new FlxSprite(x + width, y + height);
		izquierda.makeGraphic(2, 32, 0xFFFF0000);
		FlxG.state.add(derecha);
		FlxG.state.add(izquierda);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		direction = 1;
		derecha.acceleration.y = 1400;
		izquierda.acceleration.y = 1400;
		health = 1;
		damage = 1;
		acceleration.y = 1400;
		score = 700;
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(derecha, Global.tilemapActual);
		FlxG.collide(izquierda, Global.tilemapActual);
		hMove();
		super.update(elapsed);
	}
	
	override function changeDirection():Void 
	{
		super.changeDirection();
		if (Global.player.x >= x)
			direction = 1;
		else
			direction = -1;
	}
	
	private function hMove():Void
	{
		izquierda.setPosition(x - 5, y);
		derecha.setPosition(x + width + 5, y);
		if (derecha.isTouching(FlxObject.FLOOR) == false)
			direction = -1;
		else if (izquierda.isTouching(FlxObject.FLOOR) == false)
			direction = 1;
		else
			direction = direction * 1;
		velocity.x = 10 * direction;
		facing = (velocity.x >= 0) ? FlxObject.RIGHT : FlxObject.LEFT;
		animation.play("walk");
	}
}