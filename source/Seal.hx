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
enum Estados
{
	IDLE;
	WALK;
	ATTACK;
	JUMP;
}

class Seal extends Enemy
{
	private var state:Estados;
	private var timerMov:Float = 0;
	private var direction:Int;
	var derecha:FlxSprite;
	var izquierda:FlxSprite;
	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		makeGraphic(16, 8, 0xFF4003FF);
		acceleration.y = 1400;
		derecha = new FlxSprite(x + width, y + height);
		derecha.makeGraphic(2, 8, 0xFFFF0000);
		izquierda = new FlxSprite(x + width, y + height);
		izquierda.makeGraphic(2, 8, 0xFFFF0000);
		FlxG.state.add(derecha);
		FlxG.state.add(izquierda);
		state = Estados.IDLE;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		direction = 1;
		derecha.acceleration.y = 1400;
		izquierda.acceleration.y = 1400;
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(derecha, Global.tilemapActual);
		FlxG.collide(izquierda, Global.tilemapActual);
		hMove();
		super.update(elapsed);
	}
	
	private function hMove():Void
	{
		izquierda.setPosition(x - 5, y);
		derecha.setPosition(x + width + 5, y);
		if (izquierda.isTouching(FlxObject.FLOOR) && derecha.isTouching(FlxObject.FLOOR) == false)
			direction = -1;
		else if (izquierda.isTouching(FlxObject.FLOOR) == false && derecha.isTouching(FlxObject.FLOOR))
			direction = 1;
		else
			direction = direction * 1;
		velocity.x = 10 * direction;
	}
	
	private function stateMachine():Void
	{
		switch (state)
		{
			case Estados.IDLE:
				//jump();
				//hMove();
				if (velocity.y != 0)
				{
					state = Estados.JUMP;
				}
				else if ( velocity.x != 0)
				{
					state = Estados.WALK;
				}
			case Estados.JUMP:
				//hMove();
				if (velocity.y == 0)
				{
					if ( velocity.x != 0)
						state = Estados.WALK;
					else
						state = Estados.IDLE;
				}
			case Estados.WALK:
				if (velocity.x == 0)
					state = Estados.IDLE;
				if (velocity.y != 0)
					state = Estados.JUMP;
			case Estados.ATTACK:
				//jump();
				//hMove();
				if (velocity.y != 0)
					state = Estados.JUMP;
				else if ( velocity.x == 0)
					state = Estados.IDLE;
		}
	}
}