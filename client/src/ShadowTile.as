package  
{
	import flash.geom.Point;
	import MyEntity;
	import WorldTile;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ShadowTile extends WorldTile
	{
		[Embed(source = "../Assets/cube.png")]
		private const CUBE:Class;
		
		public function ShadowTile(pos :Point, height:Number) 
		{
			graphic = new Spritemap(CUBE);
			
			this.pos = pos;
			z = height;
			
			layer = -pos.y + z;
		}
		
	}

}