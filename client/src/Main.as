package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import flash.ui.ContextMenu;
	import splash.Splash;
	
	/**
	 * ...
	 * @author Alan Whitburn Haugen
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(800, 600, 60, false);
			
			/*var s:Splash = new Splash(0xFF3366, 0x202020, 30, 120, 30);
			FP.world.add(s);
			s.start(splashComplete);*/
			
			FP.world = new MyWorld; // TODO: Make a world for Network only?
			
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();
			this.contextMenu = myMenu;
		}
		
		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
		
		public function splashComplete():void
		{
			// This function is called when the splash screen finishes.
		}
		/*
			focusGained():void
	Override this; called when game gains focus. Engine 
		focusLost():void
	Override this; called when game loses focus. 
	*/
	
	}
}