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
		
		public function WorldTile(pos :Point, height:Number, type:String) 
		{
			graphic = new Spritemap(CUBE);
			
			this.pos = pos;
			this.type = type+"_"+height;
			z = height;
			
			// fix level 
		}
	
		override public function update():void 
		{
			// Fix offset after scale, closer means spread more, further away means collect them more
			if (pos) x = pos.x * Spritemap(graphic).scale;
			if (pos) y = pos.y * Spritemap(graphic).scale;
			if (pos) y += z * 55; // stack the tiles
			
			Spritemap(graphic).color = MyWorld.time;
			Spritemap(graphic).tinting = 1;
		}
	}

}