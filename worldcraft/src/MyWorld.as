package
{
	import net.flashpunk.Engine;
	import net.flashpunk.World;
	public class MyWorld extends World
	{
		public function MyWorld()
		{
			// Place entities
			add(new Enemy(425, 175));
			
			// Place world tiles
			
			// Place player
			add(new Player);
			
			// Place cursor into the World
			add(new Cursor);
		}
	}
}