package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;

class PlayState extends FlxState
{
	private var seal:Seal;
	private var tilemap:FlxTilemap;
	private var p1:Player;
	private var loader:FlxOgmoLoader;

	override public function create():Void
	{
		super.create();
		Global.enemyGroup = new FlxTypedGroup<Enemy>();
		Global.tileGroup = new FlxTypedGroup();
		Global.stairGroup = new FlxTypedGroup();
		loader = new FlxOgmoLoader(AssetPaths.testlevel__oel);
		FlxG.camera.bgColor = 0xFFCCDDFF;
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		for (i in 0...11)
		{
			if (i == 0 || i == 4 || i == 8)
				tilemap.setTileProperties(i, FlxObject.NONE);
			else
				tilemap.setTileProperties(i, FlxObject.ANY);
		}
		loader.loadEntities(placeEntities, "entities");
		FlxG.camera.follow(p1);
		add(tilemap);
		add(Global.enemyGroup);
		add(Global.tileGroup);
		add(Global.stairGroup);
		add(p1);
		Global.player = p1;
		Global.score = 0;
		Global.tilemapActual = tilemap;
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
	}

	private function placeEntities(entityName:String, entityData:Xml):Void // inicializar entidades
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		switch (entityName)
		{
			case "enemy1":
				var e:Seal = new Seal(x,y);
				Global.enemyGroup.add(e);
			case "enemy2":
				var e:FlyingSeal = new FlyingSeal(x, y);
				Global.enemyGroup.add(e);
			case "jumpTile":
				var t = new Tile(x, y, null, Tile.Tipo.BOUNCING);
				Global.tileGroup.add(t);
				t.kill();
			case "tTileLeft":
				var t = new Tile(x, y, null, Tile.Tipo.TRANSPORTLEFT);
				Global.tileGroup.add(t);
				t.kill();
			case "tTileRight":
				var t = new Tile(x, y, null, Tile.Tipo.TRANSPORTRIGHT);
				Global.tileGroup.add(t);
				t.kill();
			case "VerticalTile":
				var t = new Tile(x, y, null, Tile.Tipo.VERTICAL);
				t.loadGraphic(AssetPaths.icyFlying__png, false, 128, 32);
				Global.tileGroup.add(t);
				t.kill();
			case "HorizontalTile":
				var t = new Tile(x, y, null, Tile.Tipo.HORIZONTAL);
				t.loadGraphic(AssetPaths.icyFlying__png, false, 128, 32);
				Global.tileGroup.add(t);
				t.kill();
			case "StairTile":
				var t = new Tile(x, y, null, Tile.Tipo.STAIR);
				t.loadGraphic(AssetPaths.stair__png);
				t.setDirection(Std.parseInt(entityData.get("direction")));
				t.kill();
			case "WalrusTower":
				var w = new WalrusTower(x, y);
				var dir:Int = Std.parseInt(entityData.get("direction"));
				w.setDirection(dir);
				Global.enemyGroup.add(w);
			case "PolarBear":
				var p = new PolarBear(x, y);
				var dir:Int = Std.parseInt(entityData.get("direction"));
				p.setDirection(dir);
				Global.enemyGroup.add(p);
			case "upgradeTile":
				var f = new Tile(x, y,null, Tile.Tipo.UPGRADE);
				Global.tileGroup.add(f);
				f.kill();
			case "player":
				p1 = new Player(x, y);
			case "Boss":
				var b = new BossKillerWhale(x, y);
				add(b);
		}
	}

	override public function update(elapsed:Float):Void
	{
		entitiesRespawn();
		FlxG.collide(tilemap, p1);
		FlxG.collide(tilemap, Global.enemyGroup);
		FlxG.collide(Global.tileGroup, p1, CollideTilePlayer);
		FlxG.overlap(Global.stairGroup, p1, overlapStair);
		super.update(elapsed);
	}
	
	function entitiesRespawn() 
	{
		for (entities in Global.tileGroup)
		{
			if (entities.isOnScreen() && !entities.alive)
			entities.revive();
			else if (!entities.isOnScreen() && entities.alive)
			entities.kill();
		}
	}
	
	private function overlapStair(t:Tile,p:Player):Void
	{
		if (t.getTipo() == Tile.Tipo.STAIR)
		{
			if (FlxG.keys.pressed.UP && Global.player.get_direction()==t.getDirection())
			{
				Global.player.velocity.set(60*t.getDirection(), -72);
				Global.player.acceleration.y = 1400;
			}
			if (FlxG.keys.justReleased.UP && Global.player.get_direction()==t.getDirection())
			{
				Global.player.velocity.set(0, 0);
				Global.player.acceleration.y = 0;
			}
		}
	}

	function CollideTilePlayer(t:Tile,p:Player)
	{
		if (p.isTouching(FlxObject.FLOOR) && !p.isTouching(FlxObject.WALL))
		{
			if (t.getTipo() == Tile.Tipo.BOUNCING)
			{
				t.animation.pause;
				t.animation.play("boingACTIVE");
				p.velocity.y = -300;
				t.animation.resume;
			}
			else if (t.getTipo() == Tile.Tipo.TRANSPORTRIGHT)
				p.acceleration.x = 5000;
			else if (t.getTipo() == Tile.Tipo.TRANSPORTLEFT)
				p.acceleration.x = -5000;
		}
	}

}