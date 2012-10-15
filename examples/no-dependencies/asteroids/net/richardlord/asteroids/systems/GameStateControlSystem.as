package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import flash.ui.Keyboard;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.nodes.GameNode;
	import net.richardlord.input.KeyPoll;

	/**
	 * System to change game state based on key poll
	 * (e.g pause)
	 */
	public class GameStateControlSystem extends System
	{
		private var keyPoll:KeyPoll;
		private var gameNodes:NodeList;
		
		public function GameStateControlSystem(keyPoll:KeyPoll)
		{
			super();
			
			this.keyPoll = keyPoll;
		}
		
		override public function addToGame( game : Game ) : void
		{
			gameNodes = game.getNodeList( GameNode );
		}

		override public function update(time:Number):void
		{
			// change game state based on keypressed
			if (keyPoll.isDown(Keyboard.ESCAPE))
			{
				// escape to quit game
				var gameState:GameNode = gameNodes.head as GameNode;
				gameState.state.status = GameState.STATUS_GAME_OVER;
			}
		}
		
		override public function removeFromGame(game:Game):void
		{
			super.removeFromGame(game);
			
			this.gameNodes = null;
			this.keyPoll = null;
		}
	}
}
