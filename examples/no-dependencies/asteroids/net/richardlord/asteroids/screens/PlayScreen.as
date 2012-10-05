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
		private var _mode:int;
		public static const MODE_DISPLAY_LIST:int = 0;
		public static const MODE_STARLING:int = 1;
		
		/**
		 * Inits with rendering mode
		 * @param	mode
		 */
		public function PlayScreen(mode:int = MODE_DISPLAY_LIST)
		{
			super();
			_mode = mode;
		}
		
		override protected function init(e:Event):void
		{
			super.init(e);
			
			trace(DEBUG_TAG, 'init()');
			
			// auto start game
			_asteroids = new Asteroids(this, stage.stageWidth, stage.stageHeight);
			
			// event listeners
			this.addEventListener(AsteroidsEvent.GAME_OVER, onGameOver, false, 0, true);
			this.addEventListener(AsteroidsEvent.READY_TO_PLAY, onReadyToPlay, false, 0, true);
			
			// init game mode
			var gameMode:int;
			switch (_mode)
			{
			case MODE_STARLING:
				gameMode = Asteroids.MODE_STARLING;
				break;
				
			case MODE_DISPLAY_LIST:
			default:
				gameMode = Asteroids.MODE_DISPLAY_LIST;
				break;
			}
			_asteroids.init(gameMode);
		}
		
		/**
		 * Asteroids is ready for play
		 * @param	event
		 */
		protected function onReadyToPlay(event:Event):void
		{
			trace(DEBUG_TAG, 'onReadyToPlay()');
			
			// starts game immediately
			_asteroids.start();
		}
		
		override protected function destroy(e:Event):void
		{
			trace(DEBUG_TAG, 'destroy()');
			
			// remove event listeners
			this.removeEventListener(AsteroidsEvent.GAME_OVER, onGameOver);
			this.removeEventListener(AsteroidsEvent.READY_TO_PLAY, onReadyToPlay);
			
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