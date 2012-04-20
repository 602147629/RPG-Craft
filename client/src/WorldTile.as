package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
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
		
		private var TILE_LENGTH:uint = 108;
		private var TILE_HEIGHT:uint = 38;
		
		public function WorldTile(pos :Point, height:Number, type:String) 
		{
			graphic = new Spritemap(CUBE);
			
			this.pos = pos;
			this.type = type+"_"+height;
			z = height;
			
			layer = -pos.y;
			
			// fix level 
		}
	
		override public function update():void 
		{
			// Fix offset after scale, closer means spread more, further away means collect them more
			if (pos.y % 2 == 0) {
				if (pos) x = (pos.x*TILE_LENGTH) * Spritemap(graphic).scale;
				if (pos) y = (pos.y*TILE_HEIGHT) * Spritemap(graphic).scale;
				if (pos) y += z * 55; // stack the tiles
			}
			else {
				if (pos) x = (pos.x*TILE_LENGTH) - (TILE_LENGTH/2) * Spritemap(graphic).scale;
				if (pos) y = (pos.y*TILE_HEIGHT) * Spritemap(graphic).scale;
				if (pos) y += z * 55; // stack the tiles
			}
			
			Spritemap(graphic).color = MyWorld.time;
			Spritemap(graphic).tinting = 1;
		}
	}

}