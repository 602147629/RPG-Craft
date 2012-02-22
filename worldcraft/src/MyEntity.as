package
{
	import net.flashpunk.Entity;
	
	import net.flashpunk.graphics.Image;
	
	public class MyEntity extends Entity
	{
		[Embed(source = '../Assets/player.png')] private const MyEntity_design:Class;
		
		public function MyEntity()
		{
			graphic = new Image(MyEntity_design);
		}
	}
}