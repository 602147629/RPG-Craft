package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import flash.geom.Point;

	/**
	 * Player Class
	 * @author Alan Whitburn Haugen
	 */
	public class Player extends Entity
	{
		[Embed(source = "../Assets/player.png")]
		private const PLAYER:Class;
		
		public var sprite:Spritemap = new Spritemap(PLAYER, 128, 128);
		
		private const PLAYER_SPEED:int = 50;
		private var direction :Point = new Point();
		
		private var mouseControls :Boolean = true;
		private var current_anim  :String  = "idle";
		private var anim_row :Number = 0;
		
		private const MOUSE_RUN_DELAY :Number = 0.10;
		private var tmrRun:Alarm = new Alarm(MOUSE_RUN_DELAY, moveForwards);
		
		public function Player() 
		{
			for (var row :uint = 0; row < sprite.rows; row++) {
				// Shift to next row of animations
				var animation_shift :uint = row * sprite.columns;
				
				// Extract animations from spritemap
				sprite.add("idle_"+ String(row), [0 + animation_shift, 1 + animation_shift], 2, true);
				sprite.add("run_" + String(row), [2 + animation_shift, 3 + animation_shift],  2, true);
				sprite.add("attack_" + String(row), [4 + animation_shift, 5 + animation_shift, 6 + animation_shift, 7 + animation_shift],  24, false, resetAnimation);
			}
			
			graphic = sprite;
			
			sprite.originX = sprite.width  / 2;
			sprite.originY = sprite.height / 2;
			
			x = FP.screen.width  / 2;
			y = FP.screen.height / 2;
			
			Input.define("walk_forwards", Key.W, Key.UP);
			Input.define("walk_backwards", Key.S, Key.DOWN);
			Input.define("rotate_left", Key.A, Key.LEFT);
			Input.define("rotate_right", Key.D, Key.RIGHT);
		}
		
		override public function update():void
		{
			// Enable / Disable mouse controls
			if (Input.check("walk_forwards") || Input.check("walk_backwards") || Input.check("rotate_left") || Input.check("rotate_right")) {
				mouseControls = false;
			}
			if (Input.mouseDown) {
				mouseControls = true;
			}
			
			if (mouseControls) {
				anim_row = getMouseDirection();
				
				if (Input.mousePressed)
				{
					addTween(tmrRun);
					tmrRun.start();
				}
				else if (Input.mouseDown && current_anim == "run") {
					moveForwards();
				}
				else if (Input.mouseReleased) {
					tmrRun.cancel();
					
					// Commence attack if given time has passed without running
					if (current_anim != "run")
						attack();
					else
						resetAnimation();
				}
			}
			else {
				if (Input.check("rotate_left")) {
					var rad :Number = Math.atan(k1 / k2);
					
					var row :Number = Math.abs( rad * Math.PI );
				}
				else if (Input.check("rotate_right")) {
					direction.y += Math.sin(25);
				}
				
				if (Input.check("walk_forwards")) {
					moveForwards();
				}
				else {
					current_anim = "idle";
				}
			}
			
			sprite.play(current_anim + "_" + Math.floor(anim_row));
		}
		
		private function getMouseDirection() :int {
			var k1 :int = direction.x = FP.width/2  - Input.mouseX;
			var k2 :int = direction.y = FP.height/2 - Input.mouseY;
			
			var rad :Number = Math.atan(k1 / k2);
			
			var row :Number = Math.abs( rad * Math.PI );
			
			if (Input.mouseY > FP.height/2)
			{
				row = sprite.rows - row;
			}
			if (Input.mouseX < FP.width/2) 
			{
				sprite.scaleX = -1;
			}
			else {
				sprite.scaleX = 1;
			}
			
			return row;
		}
		
		private function moveForwards():void {
			FP.camera.x -= (direction.x / direction.length) * PLAYER_SPEED * FP.elapsed;
			FP.camera.y -= (direction.y / direction.length) * PLAYER_SPEED * FP.elapsed;
			
			x -= (direction.x / direction.length) * PLAYER_SPEED * FP.elapsed;
			y -= (direction.y / direction.length) * PLAYER_SPEED * FP.elapsed;
			
			current_anim = "run";
		}
		
		private function attack():void {
			current_anim = "attack";
		}
		
		private function resetAnimation():void {
			current_anim = "idle";
		}
		
	}

}