package  
{
	import Map;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Alan Whitburn Haugen
	 */
	public class Chunk extends Entity
	{
		private const CHUNK_WIDTH  :uint = 1024;
		private const CHUNK_HEIGHT :uint = 1024;
		
		private var map:Map;
		
		public function Chunk() 
		{
			map = new Map(CHUNK_WIDTH, CHUNK_HEIGHT, 1);
		}
		
	}

}