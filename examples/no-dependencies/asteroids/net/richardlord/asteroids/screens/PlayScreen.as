package net.richardlord.asteroids.screens
{
	import flash.events.Event;
	import net.richardlord.asteroids.Asteroids;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.events.AsteroidsEvent;
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
			
			// event listeners
			this.addEventListener(AsteroidsEvent.GAME_OVER, onGameOver, false, 0, true);
		}
		
		override protected function destroy(e:Event):void
		{
			trace(DEBUG_TAG, 'destroy()');
			
			// remove event listeners
			this.removeEventListener(AsteroidsEvent.GAME_OVER, onGameOver);
			
			// stop & destroy game
			_asteroids.stop();
			_asteroids = null;
			
			super.destroy(e);
		}
		
		/**
		 * handle event game over
		 * @param	event
		 */
		protected function onGameOver(event:AsteroidsEvent):void
		{
			// go to main screen immediately
			dispatchEvent(new ShowScreenEvent(ShowScreenEvent.SHOW_SCREEN, 'startMenu'));
		}
	}

}