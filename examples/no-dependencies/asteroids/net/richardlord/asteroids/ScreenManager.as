package net.richardlord.asteroids
{
	import flash.display.DisplayObjectContainer;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.screens.MainMenuScreen;
	import net.richardlord.asteroids.screens.PlayScreen;
	import net.richardlord.asteroids.screens.ScreenBase;
	
	/**
	 * For managing screens, including the game screen.
	 *
	 * @author Abiyasa
	 */
	public class ScreenManager
	{
		public static const DEBUG_TAG:String = 'ScreenManager';
		
		/** The main container, where we insert/remove screens */
		protected var _container:DisplayObjectContainer;
		
		public function ScreenManager(container:DisplayObjectContainer)
		{
			super();
			_container = container;
		}
		
		/**
		 * Starts the screen manager, will immediately show the first screen
		 */
		public function start():void
		{
			showScreen('startMenu');
		}
		
		/**
		 * Shows a specific screen
		 *
		 * @param	screenDetails
		 */
		protected function showScreen(screenDetails:String):void
		{
			// show screen based on event
			var theScreen:ScreenBase;
			switch (screenDetails)
			{
			case 'startMenu':
				theScreen = new MainMenuScreen();
				break;
				
			case 'playGame':
				theScreen = new PlayScreen();
				break;
			}
			if (theScreen != null)
			{
				_container.addChild(theScreen);
				theScreen.addEventListener(ShowScreenEvent.SHOW_SCREEN, onChangeScreen, false, 0, true);
			}
		}
		
		/**
		 * Handles the event generated from the current screen. Will trigger screen changes
		 *
		 * @param	e
		 */
		protected function onChangeScreen(e:ShowScreenEvent):void
		{
			var theScreen:ScreenBase = e.currentTarget as ScreenBase;
			if (theScreen == null)
			{
				trace(DEBUG_TAG, 'Error! no screen on onChangeScreen()');
				return;
			}
			theScreen.removeEventListener(ShowScreenEvent.SHOW_SCREEN, onChangeScreen);
			
			// empty container
			_container.removeChildren();
			
			// show the next screen
			showScreen(e.details);
		}
	}

}