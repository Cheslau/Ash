package net.richardlord.asteroids.screen
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.screen.ScreenBase;
	import robotlegs.bender.core.api.IContext;
	
	/**
	 * The main menu screen/View/Scene
	 * @author Abiyasa
	 */
	public class MainMenuScreen extends ScreenBase
	{
		public static const DEBUG_TAG:String = 'MainMenuScreen';
		
		protected var buttons:Array = [];
		
		[Inject]
		// TODO this is still not working!
		public var context:IContext;
		
		// TODO If injection works, remove param theContext
		public function MainMenuScreen(theContext:IContext = null)
		{
			super();
			
			if (theContext)
			{
				context = theContext;
			}
			
			// add a dummy button
			var dummyButton:SimpleButton = createDummyButton('start', 'start');
			this.addChild(dummyButton);
			buttons.push(dummyButton);
			dummyButton.addEventListener(MouseEvent.CLICK, onClickDummyButton);
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(event:Event = null):void
		{
			trace(DEBUG_TAG, 'init()');
			
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			// centerized buttons
			var stageWidth:int = this.stage.stageWidth;
			var stageHeight:int = this.stage.stageHeight;
			for each (var dummyButton:SimpleButton in buttons)
			{
				dummyButton.x = (stageWidth - dummyButton.width) / 2;
				dummyButton.y = (stageHeight - dummyButton.height) / 2;
			}
		}
	
		protected function destroy(e:Event):void
		{
			trace(DEBUG_TAG, 'destroy()');
			
			// TODO unmap stuff
		}

		protected function onClickDummyButton(e:MouseEvent):void
		{
			// dispath event
			var clickedButton:SimpleButton = e.currentTarget as SimpleButton;
			if (clickedButton != null)
			{
				trace('click button ' + clickedButton.name)
				
				context.dispatcher.dispatchEvent(new ShowScreenEvent(ShowScreenEvent.SHOW_SCREEN, 'playGame'));
			}
		}
	}

}