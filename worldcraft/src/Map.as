package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author Alan Whitburn Haugen
	 */
	public class Map extends Entity
	{
		[Embed(source="../Assets/terrain/floors.png")]
		private const MAP:Class;
		
		private const CHUNK_WIDTH  :uint = 1024;
		private const CHUNK_HEIGHT :uint = 1024;
		
		private var tilemap :Tilemap;
		private var grid :Grid;
		
		public function Map() 
		{
			tilemap = new Tilemap(MAP, CHUNK_WIDTH, CHUNK_HEIGHT, 32, 16);
			graphic = tilemap;
			layer = 1;
			
			tilemap.setRect(0,0, CHUNK_WIDTH, CHUNK_HEIGHT, 2);
			tilemap.setTile(12,5,1);
			
			grid = new Grid(CHUNK_WIDTH, CHUNK_HEIGHT, 32, 16);
			mask = grid;
			
			grid.setTile(12,5,true);
			
			type = "level";
		}
		
	}

}