package
{
	import net.flashpunk.Entity;
	
	import net.flashpunk.graphics.Image;
	
	import net.flashpunk.FP;
	
	public class MyEntity extends Entity
	{
		[Embed(source = '../Assets/player.png')] private const MyEntity_design:Class;
		
		public function MyEntity(xpos:int, ypos:int)
		{
			var gfx:Image = new Image(MyEntity_design); 
			graphic = gfx;
			
			x = xpos;
			y = ypos;
			
			setHitbox(gfx.width, gfx.height);
			type = "star";
		}
		
		public function destroy():void
		{
			// Here we could place specific destroy-behavior for the Bullet.
			FP.world.remove(this);
		}
	}
}