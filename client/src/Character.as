package  
{
	import MyEntity;
	import net.flashpunk.graphics.Spritemap;
	import flash.geom.Point;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Character extends MyEntity
	{
		
		public function Character() 
		{
		}
		
		protected function lookDirection(p:Point):void {
			var k1 :int = direction.x = x - p.x;
			var k2 :int = direction.y = y - p.y;
			
			var rad :Number = Math.atan(k1 / k2);
			
			var row :Number = Math.abs( rad * Math.PI );
			
			if (p.y > y)
			{
				row = Spritemap(graphic).rows - row;
			}
			if (p.x < x) 
			{
				Spritemap(graphic).scaleX = -1;
			}
			else {
				Spritemap(graphic).scaleX = 1;
			}
			
			anim_row = Math.floor(row);
		}
		
		override public function update():void {
			updateMovement();
			
			old.x = x;
			old.y = y;
			
			layer = -((y/38) + z); // TODO: TILE_HEIGHT: 38... fixme.
			
			// Set size and visibility
			//if (pos) Spritemap(graphic).scale = z * MyWorld.camHeight; /// Lets... make the tiles *not* scale by distance to cam
			//else Spritemap(graphic).scale = ((FP.distance(0, y+FP.halfHeight, 0, FP.camera.y) / FP.height / z) * MyWorld.camHeight);
			//Spritemap(graphic).visible
			
			// Update animation
			Spritemap(graphic).play(current_anim + "_" + anim_row);
		}
		
		protected function moveForwards():void {
			x -= (direction.x / direction.length) * ENTITY_SPEED * FP.elapsed;
			y -= (direction.y / direction.length) * ENTITY_SPEED * FP.elapsed;
			
			current_anim = "run";
		}
		
		protected function attack():void {
			current_anim = "attack";
		}
		
	}

}