package
{
	import net.flashpunk.World;
	public class MyWorld extends World
	{
		public function MyWorld()
		{
			add(new MyEntity);
		}
		
		override public function update():void
		{
			trace("MyEntity updates.");
		}
	}
}