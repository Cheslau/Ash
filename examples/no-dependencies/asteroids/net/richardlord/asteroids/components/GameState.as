package net.richardlord.asteroids.components
{
	public class GameState
	{
		public var lives : int = 0;
		public var level : int = 0;
		public var points : int = 0;
		public var width : Number = 0;
		public var height : Number = 0;

		public var status:int = STATUS_INIT;
		public static const STATUS_INIT:int = 0;
		public static const STATUS_PLAY:int = 10;
		public static const STATUS_GAME_OVER:int = 20;
		public static const STATUS_PAUSED:int = 30;
		public static const STATUS_DESTROY:int = 100;
		
		public var renderMode:int = RENDER_MODE_DISPLAY_LIST;
		public static const RENDER_MODE_DISPLAY_LIST:int = 0;
		public static const RENDER_MODE_STARLING:int = 1;
		
		
		public function GameState(width:Number = 0, height:Number = 0, initStatus:int = STATUS_INIT)
		{
			this.width = width;
			this.height = height;
			this.status = initStatus;
		}
	}
}
