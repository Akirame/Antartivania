package;

import flixel.FlxG;
import flixel.FlxObject;
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
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 8, 0xFF4003FF);
		state = Estados.IDLE;
		acceleration.y = 1400;
	}

	override public function update(elapsed:Float):Void
	{
		stateMachine();
		super.update(elapsed);
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