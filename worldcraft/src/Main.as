package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import flash.ui.ContextMenu;
	
	/**
	 * ...
	 * @author Alan Whitburn Haugen
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(800, 600, 60, false);
			
			FP.world = new MyWorld;
			
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();
			this.contextMenu = myMenu;
		}
		
		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
		/*
			focusGained():void
	Override this; called when game gains focus. Engine 
		focusLost():void
	Override this; called when game loses focus. 
	*/
	
	}
}