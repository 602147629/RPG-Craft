package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import flash.display.BitmapData;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.graphics.TiledSpritemap
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Alan Whitburn Haugen
	 */
	public class WorldTile extends MyEntity
	{
		[Embed(source = "../Assets/cube.png")]
		private const CUBE:Class;
		[Embed(source = "../Assets/cube_pixelmask.png")]
		private const PIXELMAP:Class;
		
		public var pos:Point = new Point(); // TODO: make protected?
		
		public function WorldTile()
		{	
		}
	
		override public function update():void 
		{
			// Fix offset after scale, closer means spread more, further away means collect them more
			// TODO: If scaling will always be 1... put this into init func?
			if (pos.y % 2 == 0) {
				x = (pos.x*TILE_LENGTH) * Spritemap(graphic).scale;
				y = (pos.y*TILE_HEIGHT) * Spritemap(graphic).scale;
				y += z * 55; // stack the tiles // TODO: Make var for this (55 is tile_height/2)
			}
			else {
				x = (pos.x*TILE_LENGTH) - (TILE_LENGTH/2) * Spritemap(graphic).scale;
				y = (pos.y*TILE_HEIGHT) * Spritemap(graphic).scale;
				y += z * 55; // stack the tiles // TODO: Make var for this
			}
			layer = -pos.y + z; //removeme
			Spritemap(graphic).color = MyWorld.time;
			Spritemap(graphic).tinting = 1;
			
			if (MyWorld.player.z > z+2) Spritemap(graphic).alpha = FP.distance(x, y, MyWorld.player.x, MyWorld.player.y) / 150;
			//if (MyWorld.player.z > z+2) Spritemap(graphic).alpha = FP.distance(x, y, MyWorld.player.x, MyWorld.player.y) / 150;
			
			if (collide(type, x, y)) {
				destroy();
			}
		}
	}

}