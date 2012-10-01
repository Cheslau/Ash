package net.richardlord.asteroids.components
{
	import starling.display.DisplayObject;
	
	public class StarlingDisplay
	{
		public var displayObject:DisplayObject = null;
		
		public function StarlingDisplay(displayObject:DisplayObject)
		{
			this.displayObject = displayObject;
		}
	}
}
