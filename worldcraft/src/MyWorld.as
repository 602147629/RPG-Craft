package
{
	import net.flashpunk.Engine;
	import net.flashpunk.World;
	public class MyWorld extends World
	{
		private var m_player :Player;
		
		public function MyWorld()
		{
			add(new Platform(75, 150));
			add(new Platform(300, 250));
			add(new Platform(400, 400));
			add(new Platform(210, 400));
			
			add(new MyEntity(200, 125));
			add(new MyEntity(210, 375));
			add(new MyEntity(410, 375));
			add(new MyEntity(270, 225));
			add(new MyEntity(370, 225));
			
			add(new Enemy(425, 175));
			
			add(m_player = new Player);
		}
	}
}