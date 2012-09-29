package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.System;
	import flash.ui.Keyboard;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.input.KeyPoll;

	/**
	 * System to change game state based on key poll
	 * (e.g pause)
	 */
	public class GameStateControlSystem extends System
	{
		private var keyPoll:KeyPoll;
		private var gameState:GameState;
		
		public function GameStateControlSystem(gameState:GameState, keyPoll:KeyPoll)
		{
			super();
			
			this.keyPoll = keyPoll;
			this.gameState = gameState;
		}

		override public function update(time:Number):void
		{
			// change game state based on keypressed
			if (keyPoll.isDown(Keyboard.ESCAPE))
			{
				// escape to quite game
				gameState.status = GameState.STATUS_GAME_OVER;
			}
		}
		
		override public function removeFromGame(game:Game):void
		{
			super.removeFromGame(game);
			
			this.gameState = null;
			this.keyPoll = null;
		}
	}
}
