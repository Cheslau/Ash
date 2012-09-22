package net.richardlord.asteroids.screens
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * Base for screen classes
	 * @author Abiyasa
	 */
	public class ScreenBase extends Sprite
	{
		public static const DEBUG_TAG:String = 'ScreenBase';
		
		/** Mapping between button name and event name */
		protected var _buttonEventMap:Dictionary;
		
		public function ScreenBase()
		{
			super();
			_buttonEventMap = new Dictionary();
			
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		/**
		 * Initialize when added to stage
		 * @param	event
		 */
		protected function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
		}
		
		/**
		 * Destroy when removed from stage
		 * @param	e
		 */
		protected function destroy(e:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			_buttonEventMap = null;
		}
		
		/**
		 * Create dummy button
		 * @return
		 */
		public static function createDummyButton(name:String = 'button', label:String = 'button'):SimpleButton
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
			
			var theButton:SimpleButton = new SimpleButton(texfield, texfield, texfield, texfield);
			theButton.name = name;
			return theButton;
		}
		
		
	}

}