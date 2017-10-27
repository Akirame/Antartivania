package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	private var p1:Player;
	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;

	override public function create():Void
	{
		super.create();

		loader = new FlxOgmoLoader(AssetPaths.level1__oel);
		p1 = new Player(10, 10);
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
		add(p1);
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
			case "enemy":
				var e:FlxSprite = new FlxSprite(50, 50);
		}
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(tilemap, p1);
		super.update(elapsed);
	}
}