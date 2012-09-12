package net.richardlord.asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.events.StartGameEvent;
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
			
			// TODO check screen
			
			// TODO mapping?
			
			// add dummy button
			var dummyButton:SimpleButton = createDummyButton('start');
			dummyButton.x = (contextView.stage.stageWidth - dummyButton.width) / 2;
			dummyButton.y = (contextView.stage.stageHeight - dummyButton.height) / 2;
			contextView.addChild(dummyButton);
			dummyButton.addEventListener(MouseEvent.CLICK, onClickDummyButton);
		}
		
		protected function onClickDummyButton(theEvent:MouseEvent):void
		{
			// TODO dispath event
			trace('click button')
			context.dispatcher.dispatchEvent( new StartGameEvent( contextView, contextView.stage.stageWidth, contextView.stage.stageHeight ) );
		}
		
		/**
		 * Create dummy button
		 * @return
		 */
		protected function createDummyButton(label:String = 'button'):SimpleButton
		{
			var texfield:TextField = new TextField();
			texfield.width = 100;
			texfield.height = 20;
			texfield.defaultTextFormat = new TextFormat(null, null, 0x808080, null, null, null, null, null, 'center');
			texfield.selectable = false;
			texfield.text = label;
			texfield.mouseEnabled = true;
			texfield.border = true;
			texfield.textColor = 0x808080;
			texfield.borderColor = 0x808080;
			
			return new SimpleButton(texfield, texfield, texfield, texfield);
		}
		
	}

}
