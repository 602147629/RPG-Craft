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
	public class Player extends MyEntity
	{
		[Embed(source = "../Assets/player.png")]
		private const PLAYER:Class;
		
		private var mouseControls :Boolean = true;
		private var angle :Number = 0;
		
		private const MOUSE_RUN_DELAY :Number = 0.10;
		private var tmrRun:Alarm = new Alarm(MOUSE_RUN_DELAY, moveForwards);
		
		public function Player() 
		{
			graphic = setupAnimations(new Spritemap(PLAYER, 128, 128));
			
			ENTITY_SPEED = 50;
			
			x = FP.screen.width  / 2;
			y = FP.screen.height / 2;
			
			FP.console.enable();
			
			Input.define("walk_forwards", Key.W, Key.UP);
			Input.define("walk_backwards", Key.S, Key.DOWN);
			Input.define("rotate_left", Key.A, Key.LEFT);
			Input.define("rotate_right", Key.D, Key.RIGHT);
			Input.define("attack", Key.ENTER, Key.SPACE);
		}
		
		override protected function updateMovement():void 
		{
			// Enable / Disable mouse controls
			if (Input.check("walk_forwards") || Input.check("walk_backwards") || Input.check("rotate_left") || Input.check("rotate_right")) {
				mouseControls = false;
			}
			else if (Input.mouseDown) {
				mouseControls = true;
			}
			
			// Update Controls
			if (mouseControls) {
				lookDirection(new Point(Input.mouseX + FP.camera.x, Input.mouseY + FP.camera.y));
				
				if (Input.mousePressed)
				{
					if (!tmrRun.active) addTween(tmrRun);
					tmrRun.start();
				}
				else if (Input.mouseDown && current_anim == "run") {
					moveForwards();
				}
				else if (Input.mouseReleased) {
					tmrRun.cancel();
					
					FP.console.log(current_anim + "_" + Math.floor(anim_row));
					
					// Commence attack if given time has passed without running
					if (current_anim != "run")
						attack();
					else
						resetAnimation();
				}
			}
			else {
				if (Input.check("rotate_left")) {
					angle -= .1;
				}
				else if (Input.check("rotate_right")) {
					angle += .1;
				}
				else if (Input.pressed("walk_backwards")) {
					angle += Math.PI;
				}
				
				lookDirection(new Point(x + Math.cos(angle)*10 , y + Math.sin(angle)*10) );
				
				if (Input.check(Key.A)) {
					MyWorld.camHeight+=.1;
					z+=.1;
				}
				if (Input.check(Key.Z)) {
					MyWorld.camHeight-=.1;
					z-=.1;
				}
				
				FP.console.log(MyWorld.camHeight);
				
				if (Input.check("walk_forwards")) {
					moveForwards();
				}
				else if (Input.pressed("attack")) {
					attack();
				}
				else if (current_anim != "attack"){
					current_anim = "idle";
				}
			}
		}
		
		override protected function moveForwards():void {
			FP.camera.x -= (direction.x / direction.length) * ENTITY_SPEED * FP.elapsed;
			FP.camera.y -= (direction.y / direction.length) * ENTITY_SPEED * FP.elapsed;
			
			super.moveForwards();
		}
		
	}

}