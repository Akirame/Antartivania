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
	private var p1:Player;
	private var seal:Seal;
	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var tileGroup:FlxTypedGroup<Tile>;

	override public function create():Void
	{
		super.create();
		Global.enemyGroup = new FlxTypedGroup<Enemy>();
		tileGroup = new FlxTypedGroup();
		loader = new FlxOgmoLoader(AssetPaths.level1__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(4, FlxObject.NONE);
		tilemap.setTileProperties(8, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);
		tilemap.setTileProperties(2, FlxObject.ANY);
		tilemap.setTileProperties(3, FlxObject.ANY);
		tilemap.setTileProperties(5, FlxObject.ANY);
		tilemap.setTileProperties(6, FlxObject.ANY);
		tilemap.setTileProperties(7, FlxObject.ANY);
		tilemap.setTileProperties(9, FlxObject.ANY);
		tilemap.setTileProperties(10, FlxObject.ANY);
		tilemap.setTileProperties(11, FlxObject.ANY);
		loader.loadEntities(placeEntities, "entities");
		FlxG.camera.follow(p1);
		add(tilemap);
		add(Global.enemyGroup);
		add(tileGroup);
		Global.proyectiles = new FlxTypedGroup<FlxSprite>();
		Global.player = p1;
		Global.score = 0;
		add(Global.proyectiles);
		Global.tilemapActual = tilemap;
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
	}

	private function placeEntities(entityName:String, entityData:Xml):Void // inicializar entidades
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		switch (entityName)
		{
			case "player":
				p1 = new Player(x, y);
				add(p1);
			case "enemy1":
				var e:Seal = new Seal(x,y);
				Global.enemyGroup.add(e);
			case "enemy2":
				var e:FlyingSeal = new FlyingSeal(x, y);
				Global.enemyGroup.add(e);
			case "jumpTile":
				var t = new Tile(x, y, null, Tile.Tipo.BOUNCING);
				tileGroup.add(t);
			case "tTileLeft":
				var t = new Tile(x, y, null, Tile.Tipo.TRANSPORTLEFT);
				tileGroup.add(t);
			case "tTileRight":
				var t = new Tile(x, y, null, Tile.Tipo.TRANSPORTRIGHT);
				tileGroup.add(t);
			case "VerticalTile":
				var t = new Tile(x, y, null, Tile.Tipo.VERTICAL);
				t.makeGraphic(64, 16, 0xFF00FF00);
				tileGroup.add(t);
			case "HorizontalTile":
				var t = new Tile(x, y, null, Tile.Tipo.HORIZONTAL);
				t.makeGraphic(64, 16, 0xFF00FF00);
				tileGroup.add(t);
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
			case "Fish":
				var f = new Fish(x, y);
				add(f);
		}
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(tilemap, p1);
		FlxG.collide(tilemap, Global.enemyGroup);
		FlxG.collide(tileGroup, p1, CollideTilePlayer);
		super.update(elapsed);

	}

	function CollideTilePlayer(t:Tile,p:Player)
	{
		if (p.isTouching(FlxObject.FLOOR) && !p.isTouching(FlxObject.WALL))
		{
			if (t._tipo == Tile.Tipo.BOUNCING)
			{
				t.animation.play("boingACTIVE");
				p.velocity.y = -300;
			}
			else if (t._tipo == Tile.Tipo.TRANSPORTRIGHT)
				p.acceleration.x = 5000;
			else if (t._tipo == Tile.Tipo.TRANSPORTLEFT)
				p.acceleration.x = -5000;
		}
	}

}