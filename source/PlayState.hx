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
	private var enemyGroup:FlxTypedGroup<Enemy>;
	private var tileGroup:FlxTypedGroup<Tile>;

	override public function create():Void
	{
		super.create();
		enemyGroup = new FlxTypedGroup();
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
		add(enemyGroup);
		add(tileGroup);
		
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
				enemyGroup.add(e);
			case "enemy2":
				var e:FlyingSeal = new FlyingSeal(x, y);
				enemyGroup.add(e);
			case "jumpTile":
				var t = new Tile(x, y, null, Tile.Tipo.BOUNCING);			
				t.makeGraphic(16, 16, 0xFF00FF00);
				tileGroup.add(t);
			case "tTileLeft":
				var t = new Tile(x, y, null, Tile.Tipo.TRANSPORTLEFT);
				t.makeGraphic(16, 16, 0xFF00FF00);
				tileGroup.add(t);
			case "tTileRight":
				var t = new Tile(x, y, null, Tile.Tipo.TRANSPORTRIGHT);
				t.makeGraphic(16, 16, 0xFF00FF00);
				tileGroup.add(t);
		}
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(tilemap, p1);
		FlxG.collide(tilemap, enemyGroup);
		FlxG.collide(tileGroup, p1, jumpTilePlayer);
		super.update(elapsed);
		
	}
	
	function jumpTilePlayer(t:Tile,p:Player) 
	{
		if (p.isTouching(FlxObject.FLOOR) && !p.isTouching(FlxObject.WALL))
		{
		if(t._tipo == Tile.Tipo.BOUNCING)
		p.velocity.y = -300;
		if (t._tipo == Tile.Tipo.TRANSPORTRIGHT)
		p.acceleration.x = 5000;
		if (t._tipo == Tile.Tipo.TRANSPORTLEFT)
		p.acceleration.x = -5000;
		}
	}
	
}