package net.richardlord.asteroids.events
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class ShowScreenEvent extends Event
	{
		public static const SHOW_SCREEN:String = "showScreen";
		
		public var details:String;
		public var container:DisplayObjectContainer;
		
		public function ShowScreenEvent(type:String, mainContainer:DisplayObjectContainer, screenDetails:String = null)
		{
			super(type);
			
			this.container = mainContainer;
			details = screenDetails;
		}
		
		override public function clone() : Event
		{
			return new ShowScreenEvent(type, container, details);
		}
	}
}
