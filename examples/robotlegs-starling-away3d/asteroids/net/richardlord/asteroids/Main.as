package net.richardlord.asteroids
{
	import net.richardlord.ash.integration.robotlegs.AshExtension;
	import net.richardlord.asteroids.events.StartGameEvent;
	import net.richardlord.asteroids.events.ShowScreenEvent;

	import robotlegs.bender.core.api.IContext;
	import robotlegs.bender.core.impl.ContextBuilder;
	import robotlegs.bender.extensions.commandMap.CommandMapExtension;
	import robotlegs.bender.extensions.eventCommandMap.EventCommandMapExtension;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width='320', height='240', frameRate='60', backgroundColor='#cccccc')]
	public class Main extends Sprite
	{
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, init );
			var context : IContext = ( new ContextBuilder() )
				.withContextView( this )
				.withExtension( AshExtension )
				.withExtension( CommandMapExtension )
				.withExtension( EventCommandMapExtension )
				.build();
				
			var commandMap : IEventCommandMap = context.injector.getInstance( IEventCommandMap );
			commandMap.map( StartGameEvent.START_GAME, StartGameEvent ).toCommand( StartAsteroids );
			commandMap.map( ShowScreenEvent.SHOW_SCREEN, ShowScreenEvent ).toCommand( ShowScreen );
			
			//context.dispatcher.dispatchEvent( new StartGameEvent( this, stage.stageWidth, stage.stageHeight ) );
			
			context.dispatcher.dispatchEvent(new ShowScreenEvent(ShowScreenEvent.SHOW_SCREEN, 'startMenu'));
		}
	}
}
