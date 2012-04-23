package  
{
	import WorldTile;
	import flash.geom.Point;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GrassTile extends WorldTile
	{
		[Embed(source = "../Assets/cube.png")]
		private const CUBE:Class;
		[Embed(source = "../Assets/cube_pixelmask.png")]
		private const PIXELMAP:Class;
		
		public function GrassTile(pos :Point, height:Number, type:String) 
		{
			graphic = new Spritemap(CUBE);
			
			this.pos = pos;
			this.type = type+"_"+-height;
			z = height;
			
			/*var form:BitmapData = new BitmapData(Spritemap(graphic).width,Spritemap(graphic).height,true,0);
			Spritemap(graphic).render(form, new Point(Spritemap(graphic).width/2, Spritemap(graphic).height/2), new Point(0, 0));
			var m:Pixelmask = new Pixelmask(form,-Spritemap(graphic).width/2,-Spritemap(graphic).height/2);
			mask = m;*/
			
			setHitbox(TILE_LENGTH, TILE_HEIGHT, 0, -60);
			//mask = new Pixelmask(PIXELMAP, 0, -30);
			layer = -pos.y + z;
			trace (this.type);
		}
		
	}

}