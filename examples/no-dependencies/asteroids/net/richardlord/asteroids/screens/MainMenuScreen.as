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
			
			// add dummy buttons
			var buttonConfig:Array = [
				{ label: 'start', name: 'start' },
				{ label: 'start Starling', name: 'startStarling' },
				{ label: 'start Away3D', name: 'startAway3D' }
			];
			for each (var buttonData:Object in buttonConfig)
			{
				var dummyButton:SimpleButton = createDummyButton(buttonData.name, buttonData.label);
				this.addChild(dummyButton);
				buttons.push(dummyButton);
				dummyButton.addEventListener(MouseEvent.CLICK, onClickDummyButton);
			}
			
			// add mapping between button name and event
			_buttonEventMap['start'] = 'playGame';
			_buttonEventMap['startStarling'] = 'playGameStarling';
			_buttonEventMap['startAway3D'] = 'playGameAway3D';
		}
		
		override protected function init(event:Event):void
		{
			super.init(event);
			
			trace(DEBUG_TAG, 'init()');
			
			// centerized buttons
			const paddingTop:int = 100;
			const gap:int = 5;
			
			var stageWidth:int = this.stage.stageWidth;
			var stageHeight:int = this.stage.stageHeight;
			var buttonY:int = paddingTop;
			for each (var dummyButton:SimpleButton in buttons)
			{
				dummyButton.x = (stageWidth - dummyButton.width) / 2;
				dummyButton.y = buttonY;
				
				buttonY += dummyButton.height + gap;
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