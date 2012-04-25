package  
{
	import net.flashpunk.Entity;
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
			
			layer = -((y / TILE_HEIGHT) + z);
			
			// Collision
			var cube:Entity = collide("grass_"+Math.floor(z), x, y);
			if (cube) {
				var cube_centerx :Number = cube.x + TILE_LENGTH / 2;
				var cube_centery :Number = cube.y + TILE_HEIGHT * 2;
				
				//posisjon + kollisjonsnormal * spiller_radius
				if (y < cube_centery) {
					// north ^
					if (x < cube_centerx) {
						x -= FP.distance(x, cube.x + TILE_LENGTH/2) / x;
						y -= FP.distance(y, cube.y + TILE_HEIGHT / 2) / y;
						FP.log("north");
					}
					// east ->
					else {
						x += FP.distance(x, cube.x + TILE_LENGTH/2) / x;
						y -= FP.distance(y, cube.y + TILE_HEIGHT / 2) / y;
						FP.log("east");
					}
				}
				// west <-
				else if (x < cube_centerx) {
					x -= FP.distance(x, cube.x + TILE_LENGTH/2) / x;
					y += FP.distance(y, cube.y + TILE_HEIGHT / 2) / y;
					FP.log("west");
				}
				// south \/
				else {
					x += FP.distance(x, cube.x + TILE_LENGTH/2) / x;
					y += FP.distance(y, cube.y + TILE_HEIGHT / 2) / y;
					FP.log("south");
				}
			}
			
			// Set size and visibility
			//if (pos) Spritemap(graphic).scale = z * MyWorld.camHeight; /// Lets... make the tiles *not* scale by distance to cam
			//else Spritemap(graphic).scale = ((FP.distance(0, y+FP.halfHeight, 0, FP.camera.y) / FP.height / z) * MyWorld.camHeight);
			//Spritemap(graphic).visible
			
			// Update animation
			Spritemap(graphic).play(current_anim + "_" + anim_row);
		}
		
		protected function moveForwards():void {
			x -= (direction.x / direction.length) * ENTITY_SPEED * Math.abs(direction.x)/100 * FP.elapsed; // TODO: Remove direction.x and direction.y from the equation?
			y -= (direction.y / direction.length) * ENTITY_SPEED * Math.abs(direction.y)/100 * FP.elapsed;
			
			current_anim = "run";
		}
		
		protected function attack():void {
			current_anim = "attack";
		}
		
	}

}