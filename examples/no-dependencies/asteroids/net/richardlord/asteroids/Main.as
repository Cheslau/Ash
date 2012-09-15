package net.richardlord.asteroids
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width='320', height='240', frameRate='60', backgroundColor='#ccccf0')]
	public class Main extends Sprite
	{
		private var _screenManager:ScreenManager;
		
		
		public function Main()
		{
			addEventListener(Event.ENTER_FRAME, init);
		}
		
		private function init(event:Event):void
		{
			removeEventListener( Event.ENTER_FRAME, init );
			
			// starts the screen manager
			_screenManager = new ScreenManager(this);
			_screenManager.start();
		}
	}
}
