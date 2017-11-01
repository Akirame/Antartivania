package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.tile.FlxRayCastTilemap;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;

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
	private var collisionCast:FlxSprite;
	private var direction:Int;
	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		makeGraphic(16, 8, 0xFF4003FF);
		acceleration.y = 1400;
		collisionCast = new FlxSprite(x + width, y + height);
		collisionCast.makeGraphic(2, 16, 0xFFFF0000);
		FlxG.state.add(collisionCast);
		collisionCast.acceleration.y = 200;
		state = Estados.IDLE;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		collisionCast.setFacingFlip(FlxObject.LEFT, true, false);
		collisionCast.setFacingFlip(FlxObject.RIGHT, false, false);
		direction = 1;
		flipX = false;
	}

	override public function update(elapsed:Float):Void
	{
		collisionCast.setPosition(x + width, y);
		FlxG.collide(collisionCast, Global.tilemapActual);
		hMove();
		super.update(elapsed);
	}
	
	private function hMove():Void
	{
		if (collisionCast.isTouching(FlxObject.FLOOR))
			direction = direction * 1;
		else
			direction = direction * -1;
		velocity.x = 10 * direction;
		trace(velocity.x);
		facing = (velocity.x > 0) ? FlxObject.RIGHT : FlxObject.LEFT;
		collisionCast.facing = (velocity.x > 0) ? FlxObject.RIGHT : FlxObject.LEFT;
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