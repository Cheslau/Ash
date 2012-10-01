package net.richardlord.asteroids
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
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
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// starts the screen manager
			_screenManager = new ScreenManager(this);
			_screenManager.start();
		}
	}
}
