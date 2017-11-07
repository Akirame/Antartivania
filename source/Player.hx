package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
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
	ATTACK;
}

enum Upgrades
{
	NONE;
	AXE;
	KNIFE;
	SHIELD;
}
class Player extends FlxSprite
{

	private var state:Estado = Estado.FALL;
	private var direction(get, null):Int = 0;
	private var whip:Whip;
	private var timerAttack:Float = 0;
	private var attacking:Bool;
	private var energy:Int;
	private var secondary:Upgrades = Upgrades.SHIELD;
	private var axe:AxeSecondary;
	private var knife:KnifeSecondary;
	private var shield:ShieldSecondary;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		makeGraphic(16, 32, 0xFF0000FF);		
		acceleration.y = 1400;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("idle", [0,1], 8, true);
		animation.add("run", [0, 1, 2, 3, 4, 5], 8, true);
		animation.add("jump", [3], 8, true);
		whip = new Whip(x, y);
		whip.makeGraphic(40, 16, 0xFF00FFFF);
		FlxG.state.add(whip);
		direction = 1;
		whip.kill();
		attacking = false;
		health = 8;
		energy = 0;
	}

	override public function update(elapsed:Float):Void
	{
	
		stateMachine();
		super.update(elapsed);
		velocity.x = 0;
		acceleration.x = 0;
		attackDirection();
		if (FlxG.keys.pressed.UP && FlxG.keys.justPressed.X && energy>0)
		{
			switch (secondary) 
			{
				case Upgrades.NONE:
					
				case Upgrades.AXE:
					axe = new AxeSecondary(x, y);
					FlxG.state.add(axe);
					energy--;
				case Upgrades.KNIFE:
					knife = new KnifeSecondary(x, y);
					FlxG.state.add(knife);
					energy--;
				case Upgrades.SHIELD:
					shield = new ShieldSecondary(x, y);
					FlxG.state.add(shield);
					energy--;
			}
		}
	}

	private function stateMachine():Void
	{
		switch (state)
		{
			case Estado.IDLE:
				//animation.play("idle");
				hMove();
				jump();
				attack();
				if (attacking)
					state = Estado.ATTACK;
				if (velocity.y != 0)
					state = Estado.JUMP;
				else if (velocity.x != 0)
					state = Estado.RUN;

			case Estado.RUN:
				//animation.play("run");
				hMove();
				jump();
				attack();
				if (attacking)
					state = Estado.ATTACK;
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
				//animation.play("jump");
				if (!isTouching(FlxObject.FLOOR))
					velocity.x += 100 * direction;
				attack();
				if (attacking)
					state = Estado.ATTACK;
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

			case Estado.ATTACK:
				if (!isTouching(FlxObject.FLOOR))
					velocity.x += 100 * direction;
				timerAttack += FlxG.elapsed;
				if (timerAttack > 0.5)
				{
					timerAttack = 0;
					whip.kill();
					attacking = false;				
					state = Estado.IDLE;
				}
		}
	}

	private function jump():Void
	{

		if (FlxG.keys.pressed.Z)
		{
			velocity.y -= 300;
		}
	}

	private function attack():Void
	{
		if (FlxG.keys.justPressed.X)
		{
			whip.revive();
			attacking = true;
		}
	}

	private function hMove():Void
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
	
	private function attackDirection():Void 
	{
		if (direction==1)
			whip.setPosition(x + width, y);
		else if (direction ==-1)
			whip.setPosition(x - whip.width, y);
		whip.setPosition(whip.x, y);
	}
	
	public function takeHealth(cuant:Int):Void
	{
		if (health < 10)
			health += cuant;
		else
			health = 10;
	}
	
	public function addEnergy():Void
	{
		energy++;
	}
	
	public function getEnergy():Int
	{
		return energy;
	}
	
	public function takeDamage(damage:Int):Void
	{
		health -= damage;
		
	}
	
	public function get_direction():Int 
	{
		return direction;
	}
	
}