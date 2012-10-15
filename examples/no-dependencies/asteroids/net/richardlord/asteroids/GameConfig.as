package net.richardlord.asteroids
{
	public class GameConfig
	{
		public var width : Number;
		public var height : Number;
		
		public var renderMode:int = RENDER_MODE_DISPLAY_LIST;
		public static const RENDER_MODE_DISPLAY_LIST:int = 0;
		public static const RENDER_MODE_STARLING:int = 1;
		public static const RENDER_MODE_AWAY3D:int = 2;
	}
}
