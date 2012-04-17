package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.PreRotation;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Cursor extends Entity
	{
		[Embed(source = "../Assets/cursor.png")]
		private const CURSOR:Class;
		
		public function Cursor()
		{
			var gfx:PreRotation = new PreRotation(CURSOR); 
			graphic = gfx;
			
			gfx.originX = gfx.width  / 2;
			gfx.originY = gfx.height / 2;
			
			Input.mouseCursor = "hide";
		}
		
		override public function update():void {
			x = Input.mouseX + FP.camera.x;
			y = Input.mouseY + FP.camera.y;
			
			var k1 :int = FP.width/2 - Input.mouseX;
			var k2 :int = FP.height/2 - Input.mouseY;
			
			var rad :Number = Math.atan(k1 / k2);
			
			PreRotation(graphic).angle = rad * 45;
			
			if (Input.mouseY > FP.height / 2)
				PreRotation(graphic).scale = -1;
			else
				PreRotation(graphic).scale = 1;
		}
		
	}

}