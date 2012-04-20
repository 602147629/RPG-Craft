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
		public static var time:Number = 1; // clock. effects entity colours
		public static var isNetwork:Boolean = true;
		public var socket:Socket = new Socket();
		public static var map:Map;
		
		public function MyWorld()
		{
			if (isNetwork) {
				//fscommand("../server/Server/Debug/server.exe");
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
				map = new Map;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (time < 255) time += 0x000001;
		}
		
		private function onConnect(e:Event):void {
		}
		
		private function onClose(e:Event):void {
			trace ("Connection lost");
		}
		
		private function onError(e:IOErrorEvent):void {
			trace (e.text);
		}
		
		// All incoming data is recieved and notified here
		private function onResponse(e:ProgressEvent):void {
			// Place world tiles
			map = new Map(socket.readUTFBytes(e.bytesLoaded));
			trace (e);
			
		}
		
		private function onSecError(e:SecurityErrorEvent):void {
			trace (e.text);
		}
	}
}