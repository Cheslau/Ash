package net.richardlord.asteroids.screen
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Base for screen classes
	 * @author Abiyasa
	 */
	public class ScreenBase extends Sprite
	{
		
		public function ScreenBase()
		{
			super();
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