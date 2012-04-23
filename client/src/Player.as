package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import flash.geom.Point;
	import net.flashpunk.World;

	/**
	 * Player Class
	 * @author Alan Whitburn Haugen
	 */
	public class Player extends Character
	{
		[Embed(source = "../Assets/player.png")]
		private const PLAYER:Class;
		
		private var mouseControls :Boolean = true;
		private var angle :Number = 0;
		
		private var cubez:Number = 0;
		public var cubeshadow :ShadowTile = new ShadowTile(new Point(), 0); // TODO: Make own class for this. move out of player.as
		
		private const MOUSE_RUN_DELAY :Number = 0.10;
		private var tmrRun:Alarm = new Alarm(MOUSE_RUN_DELAY, moveForwards);
		
		public function Player() 
		{
			graphic = setupAnimations(new Spritemap(PLAYER, 128, 128));
			//setHitbox(TILE_LENGTH, TILE_HEIGHT * 2, 0, -30);
			
			ENTITY_SPEED = 50;
			
			x = FP.halfWidth;
			y = FP.halfHeight;
			
			FP.console.enable();
			
			Spritemap(cubeshadow.graphic).alpha = 0.2;
			
			Input.define("walk_forwards", Key.W, Key.UP);
			Input.define("walk_backwards", Key.S, Key.DOWN);
			Input.define("rotate_left", Key.A, Key.LEFT);
			Input.define("rotate_right", Key.D, Key.RIGHT);
			Input.define("attack", Key.ENTER, Key.SPACE);
			Input.define("create_cube", Key.C);
		}
		
		override protected function updateMovement():void 
		{
			// Enable / Disable mouse controls
			if (Input.check("walk_forwards") || Input.check("walk_backwards")) {
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
				
				// TODO: Remove this hack... maybe set it outside this ifstatement
				if (Input.check(Key.A)) {
					MyWorld.camHeight-=.1; // Fix: no more than +1 player.Z
					cubez-=.1;
				}if (Input.check(Key.Z)) {
					MyWorld.camHeight+=.1;
					cubez+=.1;
				}
				
				cubeshadow.pos.x = Math.floor((Input.mouseX+FP.camera.x) / 108 + 0.5);
				cubeshadow.pos.y = Math.floor((Input.mouseY+FP.camera.y) / (108 / 2.5));
				cubeshadow.z = Math.floor(cubez);
				
				// TODO: Duplicated in the else statement...
				if (Input.pressed("create_cube")) {
					MyWorld.map.setTile(Input.mouseX+FP.camera.x,Input.mouseY+FP.camera.y,cubez,"grass");
				}
				
				// Collision
				var cube:Entity = collide("grass_"+Math.floor(z), x, y);
				if (cube) {
					trace ("collision");
					//posisjon + kollisjonsnormal * spiller_radius
					x = old.x + FP.distance(x, cube.x)/old.x;
					y = old.y + FP.distance(y, cube.y)/old.y;
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
				
				if (Input.check("walk_forwards")) {
					moveForwards();
				}
				else if (Input.pressed("attack")) {
					attack();
				}
				else if (current_anim != "attack"){
					current_anim = "idle";
				}
				
				cubez = z;
				
				cubeshadow.pos.x = Math.floor(((x - 50) + Math.cos(angle) * 75) / 108 + 0.5);  // TOOD: Duplacate duplacate... same in settile func
				cubeshadow.pos.y = Math.floor(((y-50) + Math.sin(angle)*75) / (108 / 2.5));
				cubeshadow.z = Math.floor(cubez);
				
				if (Input.pressed("create_cube")) {
					MyWorld.map.setTile((x-50) + Math.cos(angle)*75,(y-50) + Math.sin(angle)*75,cubez,"grass");
				}
			}
			
			FP.console.log(MyWorld.camHeight);
		}
		
		override protected function moveForwards():void {
			super.moveForwards();
			
			FP.camera.x = x - FP.halfWidth;
			FP.camera.y = y - FP.halfHeight;
		}
		
	}

}