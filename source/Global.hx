package;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author ...
 */
class Global 
{
	static public var tilemapActual:FlxTilemap;
	static public var proyectiles:FlxTypedGroup<FlxSprite>;
	static public var enemyGroup:FlxTypedGroup<Enemy>;
	static public var player:Player;
	static public var score:Int;
	static public var tileGroup:FlxTypedGroup<Tile>;
}