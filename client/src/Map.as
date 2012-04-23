package  
{
	/*import net.flashpunk.Entity;
	import flash.net.URLLoader;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;*/
	import net.flashpunk.FP;
	import flash.events.Event;
    import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.adobe.serialization.json.JSON;

	/**
	 * Map.as for map metadata
	 * @author Alan Whitburn Haugen
	 */
	public class Map
	{
		/*[Embed(source="../Assets/terrain/floors.png")]
		private const MAP:Class;
		
		private const CHUNK_WIDTH  :uint = 1024;
		private const CHUNK_HEIGHT :uint = 1024;
		
		private var tilemap :Tilemap;
		private var grid :Grid;*/
		
		private var urlLoader:URLLoader = new URLLoader();
		
		private var TILE_LENGTH:uint = 108;
		private var TILE_HEIGHT:uint = 38;
		
		
		public function Map(json:String = null) 
		{
			/*tilemap = new Tilemap(MAP, CHUNK_WIDTH, CHUNK_HEIGHT, 32, 16);
			graphic = tilemap;
			layer = 1;
			
			tilemap.setRect(0,0, CHUNK_WIDTH, CHUNK_HEIGHT, 2);
			tilemap.setTile(12,5,1);
			
			grid = new Grid(CHUNK_WIDTH, CHUNK_HEIGHT, 32, 16);
			mask = grid;
			
			grid.setTile(12,5,true);
			
			type = "level";*/
			if (json) {
				// TODO: this is duplicated.. fix with funcs
				var levelData:Object = JSON.decode(json, true);
				
				for each(var worldBase:Object in levelData) {
					// cubes
					for each(var cube:Object in worldBase) {
						FP.world.add(new GrassTile(new Point(cube["x"],cube["y"]), cube["z"], cube["type"]));
					}
				}
			}
			else {
				var request:URLRequest = new URLRequest("level.json");
				urlLoader.addEventListener(Event.COMPLETE, loadLevel);
				urlLoader.load(request);
			}
			
			//tilemap.push(new WorldTile(new Point(100,100), 3, "grass"));
			/*tilemap.push(new WorldTile(new Point(100+TILE_LENGTH,100), 2, "grass"));
			tilemap.push(new WorldTile(new Point(100+TILE_LENGTH*2,100), 2, "grass"));
			tilemap.push(new WorldTile(new Point(100 + TILE_LENGTH * 3, 100), 2, "grass"));
			*/
			//tilemap.push(new WorldTile(new Point(100,100), 1, "grass"));
			/*tilemap.push(new WorldTile(new Point(100+TILE_LENGTH,100), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100+TILE_LENGTH*2,100), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100 + TILE_LENGTH * 3, 100), 1, "grass"));
			
			tilemap.push(new WorldTile(new Point(100-TILE_LENGTH/2,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100-TILE_LENGTH/2+TILE_LENGTH,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100-TILE_LENGTH/2+TILE_LENGTH*2,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100 - TILE_LENGTH / 2 + TILE_LENGTH * 3, 100 + TILE_HEIGHT), 1, "grass"));
			
			TILE_HEIGHT = 38*2;
			
			tilemap.push(new WorldTile(new Point(100,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100+TILE_LENGTH,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100+TILE_LENGTH*2,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100+ TILE_LENGTH * 3, 100 + TILE_HEIGHT), 1, "grass"));
			TILE_HEIGHT = 38*3;
			
			tilemap.push(new WorldTile(new Point(100-TILE_LENGTH/2,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100-TILE_LENGTH/2+TILE_LENGTH,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100-TILE_LENGTH/2+TILE_LENGTH*2,100+TILE_HEIGHT), 1, "grass"));
			tilemap.push(new WorldTile(new Point(100-TILE_LENGTH/2+TILE_LENGTH*3,100+TILE_HEIGHT), 1, "grass"));*/
			
			
		}
		
		private function loadLevel(e:Event):void {
            urlLoader.removeEventListener(Event.COMPLETE, loadLevel);
            
            var levelData:Object = JSON.decode(urlLoader.data, true);
            
            for each(var worldBase:Object in levelData) {
				// cubes
                for each(var cube:Object in worldBase) {
					FP.world.add(new GrassTile(new Point(cube["x"],cube["y"]), cube["z"], cube["type"]));
                }
            }
			
			// Place entities
			//FP.world.add(new Enemy(425, 175));
        }
		
		public function setTile(x:Number, y:Number, z:Number, type:String):void {
			// Convert to local space
			FP.world.add(new GrassTile(new Point(Math.floor(x/TILE_LENGTH+0.5), Math.floor(y/(TILE_LENGTH/2.5))), Math.floor(z), type)); 
			// 2.5 is a magic number to place them..
			// if already there, remove..?
			
			if (MyWorld.isNetwork) {
				//MyWorld.socket.connect("localhost", 13);
				MyWorld.socket.writeInt(Math.floor(x/TILE_LENGTH));
				MyWorld.socket.writeInt(Math.floor(y/(TILE_LENGTH/2.5)));
				MyWorld.socket.writeInt(Math.floor(z));
			}
		}
		
	}

}