package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import flash.geom.Point;
	
	public class Enemy extends Character
	{
		[Embed(source="../Assets/enemy.png")] private const ENEMY:Class;
		
		public function Enemy(xpos:int, ypos:int)
		{
			graphic = setupAnimations(new Spritemap(ENEMY, 128, 128));
			
			x = xpos;
			y = ypos;
			
			setHitbox(Spritemap(graphic).width, Spritemap(graphic).height);
			type = "enemy";
		}
		
		override protected function updateMovement():void 
		{
			var p:Point = new Point(Input.mouseX + FP.camera.x, Input.mouseY + FP.camera.y);
			lookDirection(p);
			
			moveForwards();
		}
		
	}

}