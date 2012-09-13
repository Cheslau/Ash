package net.richardlord.asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.screen.MainMenuScreen;
	import net.richardlord.asteroids.screen.PlayScreen;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.core.api.IContext;
	
	/**
	 * A start screen before the game starts
	 * @author Abiyasa
	 */
	public class ShowScreen
	{
		[Inject]
		public var injector:Injector;
		
		[Inject]
		public var event:ShowScreenEvent;
		
		[Inject]
		public var contextView:DisplayObjectContainer;
		
		[Inject]
		public var context:IContext;
		
		public function ShowScreen()
		{
			super();
		}
		
		/** Called by RL Command */
		public function execute():void
		{
			prepareView();
		}
		
		/**
		 * Prepare view
		 */
		protected function prepareView():void
		{
			var screenDetails:String = event.details;
			
			trace('will show screen', screenDetails);
			
			// empty context view
			contextView.removeChildren();
			
			// show screen based on event
			switch (screenDetails)
			{
			case 'startMenu':
				var mainMenuScreen:MainMenuScreen = new MainMenuScreen(context);
				contextView.addChild(mainMenuScreen);
				break;
				
			case 'playGame':
				var playScreen:PlayScreen = new PlayScreen(context);
				contextView.addChild(playScreen);
				break;
			}
		}
		
	}

}
