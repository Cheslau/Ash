package net.richardlord.asteroids.screens
{
	import flash.events.Event;
	import net.richardlord.asteroids.Asteroids;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.screens.ScreenBase;
	
	/**
	 * ...
	 * @author Abiyasa
	 */
	public class PlayScreen extends ScreenBase
	{
		private var _asteroids:Asteroids;
		
		public function PlayScreen()
		{
			super();
		}
		
		override protected function init(e:Event):void
		{
			super.init(e);
			
			trace(DEBUG_TAG, 'init()');
			
			// auto start game
			_asteroids = new Asteroids(this, stage.stageWidth, stage.stageHeight);
			_asteroids.start();
		}
		
		override protected function destroy(e:Event):void
		{
			super.destroy(e);
			
			trace(DEBUG_TAG, 'destroy()');
			
			// stop & destroy game
			_asteroids.stop();
			_asteroids = null;
		}
	}

}