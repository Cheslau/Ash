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
	
	/**
	 * A start screen before the game starts
	 * @author Abiyasa
	 */
	public class ShowScreen extends Sprite
	{
		[Inject]
		public var injector:Injector;
		
		[Inject]
		public var event:ShowScreenEvent;

		
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
			var container:DisplayObjectContainer = event.container;
			
			trace('will show screen', screenDetails);
			
			container.removeChildren();
			
			// TODO check screen
			
			// TODO mapping?
			
			// add dummy button
			var dummyButton:SimpleButton = createDummyButton('start');
			dummyButton.x = (container.stage.stageWidth - dummyButton.width) / 2;
			dummyButton.y = (container.stage.stageHeight - dummyButton.height) / 2;
			container.addChild(dummyButton);
			container.addEventListener(MouseEvent.CLICK, onClickDummyButton);
		}
		
		protected function onClickDummyButton(theEvent:MouseEvent):void
		{
			// TODO dispath event
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