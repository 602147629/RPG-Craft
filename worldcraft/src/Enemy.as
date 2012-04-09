package  
{
	import net.flashpunk.Entity;
	
	import net.flashpunk.graphics.Image;
	
	import net.flashpunk.FP;
	
	public class Enemy extends Entity
	{
		[Embed(source="../Assets/enemy.png")] private const ENEMY:Class;
		
		public function Enemy(xpos:int, ypos:int)
		{
			var gfx:Image = new Image(ENEMY); 
			graphic = gfx;
			
			//x = xpos;
			//y = ypos;
			
			//setHitbox(gfx.width, gfx.height);
			//type = "enemy";
		}
		
	}

}