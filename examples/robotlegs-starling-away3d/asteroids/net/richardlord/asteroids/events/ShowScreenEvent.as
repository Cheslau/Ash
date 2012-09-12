package net.richardlord.asteroids.events
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class ShowScreenEvent extends Event
	{
		public static const SHOW_SCREEN:String = "showScreen";
		
		public var details:String;
		
		public function ShowScreenEvent(type:String, screenDetails:String = null)
		{
			super(type);
			
			details = screenDetails;
		}
		
		override public function clone() : Event
		{
			return new ShowScreenEvent(type, details);
		}
	}
}
