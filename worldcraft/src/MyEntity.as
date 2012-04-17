package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	public class MyEntity extends Entity
	{
		protected var ENTITY_SPEED :uint = 100;
		protected var direction:Point = new Point();
		
		protected var current_anim  :String  = "idle";
		protected var anim_row :Number = 0;
		
		public function MyEntity()
		{
		}
		
		protected function setupAnimations(sprite:Spritemap):Spritemap {
			for (var row :uint = 0; row < sprite.rows; row++) {
				// Shift to next row of animations
				var animation_shift :uint = row * sprite.columns;
				
				// Extract animations from spritemap
				sprite.add("idle_"+ String(row), [0 + animation_shift, 1 + animation_shift], 2, true);
				sprite.add("run_" + String(row), [2 + animation_shift, 3 + animation_shift],  2, true);
				sprite.add("attack_" + String(row), [4 + animation_shift, 5 + animation_shift, 6 + animation_shift, 7 + animation_shift],  24, false, resetAnimation);
			}
			
			sprite.originX = sprite.width  / 2;
			sprite.originY = sprite.height / 2;
			
			return sprite;
		}
		
		protected function updateMovement():void {
			// AI / Controls
		}
		
		override public function update():void {
			updateMovement();
			
			// Collision
			if (collide("level", x, y)) {
				trace ("collision");
			}
			
			// Set size and visibility
			
			
			// Update animation
			Spritemap(graphic).play(current_anim + "_" + anim_row);
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
		
		protected function moveForwards():void {
			x -= (direction.x / direction.length) * ENTITY_SPEED * FP.elapsed;
			y -= (direction.y / direction.length) * ENTITY_SPEED * FP.elapsed;
			
			current_anim = "run";
		}
		
		protected function attack():void {
			current_anim = "attack";
		}
		
		protected function resetAnimation():void {
			current_anim = "idle";
		}
		
		public function destroy():void
		{
			// Here we could place specific destroy-behavior for the Entity.
			FP.world.remove(this);
		}
	}
}