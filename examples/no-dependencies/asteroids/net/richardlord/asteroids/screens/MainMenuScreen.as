package net.richardlord.asteroids.screens
{
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.richardlord.asteroids.events.ShowScreenEvent;
	import net.richardlord.asteroids.screens.ScreenBase;
	
	/**
	 * The main menu screen/View/Scene
	 * @author Abiyasa
	 */
	public class MainMenuScreen extends ScreenBase
	{
		public static const DEBUG_TAG:String = 'MainMenuScreen';
		
		protected var buttons:Array = [];
		
		public function MainMenuScreen()
		{
			super();
			
			// add a dummy button
			var dummyButton:SimpleButton = createDummyButton('start', 'start');
			this.addChild(dummyButton);
			buttons.push(dummyButton);
			dummyButton.addEventListener(MouseEvent.CLICK, onClickDummyButton);
			
			// add mapping between button name and event
			_buttonEventMap['start'] = 'playGame';
		}
		
		override protected function init(event:Event):void
		{
			super.init(event);
			
			trace(DEBUG_TAG, 'init()');
			
			// centerized buttons
			var stageWidth:int = this.stage.stageWidth;
			var stageHeight:int = this.stage.stageHeight;
			for each (var dummyButton:SimpleButton in buttons)
			{
				dummyButton.x = (stageWidth - dummyButton.width) / 2;
				dummyButton.y = (stageHeight - dummyButton.height) / 2;
			}
		}
	
		override protected function destroy(e:Event):void
		{
			trace(DEBUG_TAG, 'destroy()');
			
			// TODO unmap stuff
			
			super.destroy(e);
		}

		protected function onClickDummyButton(e:MouseEvent):void
		{
			// dispath event
			var clickedButton:SimpleButton = e.currentTarget as SimpleButton;
			if (clickedButton != null)
			{
				var buttonName:String = clickedButton.name;
				
				trace('click button ' + buttonName);
				
				// mapping between button name and event name
				var eventName:String;
				if (_buttonEventMap.hasOwnProperty(buttonName))
				{
					eventName = _buttonEventMap[buttonName];
					
					trace(DEBUG_TAG, 'will generate event', eventName);
					
					dispatchEvent(new ShowScreenEvent(ShowScreenEvent.SHOW_SCREEN, eventName));
				}
				else  // unknown or unmapped button
				{
					trace(DEBUG_TAG, 'button is unmapped, cannot generate event');
				}
			}
		}
	}

}