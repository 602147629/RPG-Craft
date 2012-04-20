package
{
	import flash.system.FSCommand;
	import net.flashpunk.Engine;
	import net.flashpunk.World;
	import flash.net.Socket;
	import flash.events.*;
	import Map;
	
	public class MyWorld extends World
	{
		public static var camHeight:Number = 1; // five units up
		public static var time:Number = 1; // clock. effects entity colors
		public static var isNetwork:Boolean = true;
		
		public function MyWorld()
		{
			if (isNetwork) {
				//fscommand("../server/Server/Debug/server.exe");
				var socket:Socket = new Socket();
				//Security.allowDomain("*");

				socket.addEventListener(Event.CONNECT, onConnect);
				socket.addEventListener(Event.CLOSE, onClose);
				socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, onResponse);
				socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
				
				socket.connect("localhost", 13);
				
				trace ("test");
			}
			else {
				// Place world tiles
				var map:Map = new Map;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (time < 255) time += 0x000001;
		}
		
		private function onConnect(e:Event):void {
			// Place world tiles
			var map:Map = new Map;
		}
		
		private function onClose(e:Event):void {
			trace ("Connection lost");
		}
		
		private function onError(e:IOErrorEvent):void {
			trace (e.text);
		}
		
		// All data is recieved here
		private function onResponse(e:ProgressEvent):void {
			trace (e);
		}
		
		private function onSecError(e:SecurityErrorEvent):void {
			trace (e.text);
		}
	}
}