package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author dad
 */

enum Estado
{
	IDLE;
	RUN;
	JUMP;
	FALL;
}
class Player extends FlxSprite
{

	private var state:Estado = Estado.IDLE;
	private var direction:Int = 0;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		makeGraphic(16, 16, 0xFFFF0000);
		acceleration.y = 1400;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}

	override public function update(elapsed:Float):Void
	{
		velocity.x = 0;
		stateMachine();	
		super.update(elapsed);
	}

	function stateMachine():Void
	{
		switch (state)
		{
			case Estado.IDLE:
				hMove();
				jump();
				if (velocity.y != 0)
					state = Estado.JUMP;
				else if (velocity.x != 0)
					state = Estado.RUN;

			case Estado.RUN:
				hMove();
				jump();
				
				if (!isTouching(FlxObject.FLOOR))
				{
				state = Estado.FALL;
				}
				else if (velocity.y != 0)
					state = Estado.JUMP;
				else if (velocity.x == 0)
				{
					state = Estado.IDLE;
					direction = 0;
				}
				

			case Estado.JUMP:
				if (!isTouching(FlxObject.FLOOR))
					velocity.x += 100 * direction;
				if (velocity.y == 0)
				{
					if (velocity.x == 0)
					{
						state = Estado.IDLE;
						direction = 0;
					}
					else
						state = Estado.RUN;
				}
			case Estado.FALL:
				velocity.x = 0;
				if (isTouching(FlxObject.FLOOR))
					state = Estado.IDLE;
		}
	}

	function jump():Void
	{

		if (FlxG.keys.pressed.Z)
		{
			velocity.y -= 300;
		}
	}

	function hMove():Void
	{
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x -= 100;
			direction = -1;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x += 100;
			direction = 1;
		}
		if (isTouching(FlxObject.FLOOR) && velocity.y == 0)
		{
			if (velocity.x != 0)
			{
				facing = (velocity.x > 0) ? FlxObject.RIGHT : FlxObject.LEFT;
			}
		}
	}

}