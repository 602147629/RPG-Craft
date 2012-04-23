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
		protected var old:Point = new Point();
		
		private var scaling_offset:Point = new Point(2,2);
		protected var playerz :Number = 1;
		protected var xangle :Number = 0;
		public var z :Number = 1; // TODO: Set to private again?
		
		protected var current_anim  :String  = "idle";
		protected var anim_row :Number = 0;
		
		public var isCollided :Boolean = false;
		
		protected var TILE_LENGTH:uint = 108;
		protected var TILE_HEIGHT:uint = 38;
		
		public function MyEntity()
		{
		}
		
		protected function setupAnimations(sprite:Spritemap):Spritemap {
			for (var row :uint = 0; row < sprite.rows; row++) {
				// Shift to next row of animations
				var animation_shift :uint = row * sprite.columns;
				
				// Extract animations from spritemap TODO: Make array of these animations to make this generic
				sprite.add("idle_"+ String(row), [0 + animation_shift, 1 + animation_shift], 2, true);
				sprite.add("run_" + String(row), [2 + animation_shift, 3 + animation_shift],  2, true);
				sprite.add("attack_" + String(row), [4 + animation_shift, 5 + animation_shift, 6 + animation_shift, 7 + animation_shift],  24, false, resetAnimation);
			}
			
			sprite.originX = sprite.width  / 2;
			sprite.originY = sprite.height / 2;
			
			return sprite;
		}
		
		protected function resetAnimation():void {
			current_anim = "idle";
		}
		
		protected function updateMovement():void {
			// AI / Controls
		}
		
		public function destroy():void
		{
			// Here we could place specific destroy-behavior for the Entity.
			FP.world.remove(this);
		}
	}
}