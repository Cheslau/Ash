package net.richardlord.asteroids.systems
{
	import away3d.core.managers.Stage3DProxy;
	import flash.display.Stage;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.components.StarlingDisplay;
	import net.richardlord.asteroids.nodes.StarlingRenderNode;
	import net.richardlord.asteroids.screens.DummyStarlingContainer;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import flash.display3D.Context3DCompareMode;
	
	
	/**
	 * Render system using Starling Framework
	 * @author Abiyasa
	 */
	public class StarlingRenderSystem extends System
	{
		public var container:DisplayObjectContainer;
		public var stage3dProxy:Stage3DProxy;
		public var starling:Starling;
		
		private var nodes:NodeList;
		
		
		public function StarlingRenderSystem(stage:Stage, stage3Dproxy:Stage3DProxy)
		{
			this.stage3dProxy = stage3Dproxy;
			
			// init starling
			Starling.multitouchEnabled = false;
			Starling.handleLostContext = true;
			starling = new Starling(DummyStarlingContainer, stage, stage3dProxy.viewPort, stage3dProxy.stage3D);
			starling.simulateMultitouch = false;
			starling.enableErrorChecking = true;
			starling.addEventListener(Event.ROOT_CREATED, onStarlingRootCreated);
		}
		
		/**
		 *
		 * @param	event
		 */
		private function onStarlingRootCreated(event:Event):void
		{
			starling.removeEventListener(Event.ROOT_CREATED, onStarlingRootCreated);
			
			trace('initStarling with context=', stage3dProxy.stage3D.context3D.driverInfo,
				'viewport=' + stage3dProxy.viewPort);
			trace('Starling root is ready!');
			
			// init Starling here
			this.container = starling.root as DisplayObjectContainer;
			
			// Note: for fixing transparent issue. see https://github.com/PrimaryFeather/Starling-Framework/issues/178
			stage3dProxy.context3D.setDepthTest(false, Context3DCompareMode.ALWAYS);
			
			// TODO should be handled by starling frame provider
			starling.start();
			
			// TODO notify ready to play
			//notifyReadyToPlay();
		}
		
		override public function addToGame(game:Game):void
		{
			nodes = game.getNodeList(StarlingRenderNode);
			for(var node:StarlingRenderNode = nodes.head; node; node = node.next)
			{
				addToDisplay(node);
			}
			nodes.nodeAdded.add(addToDisplay);
			nodes.nodeRemoved.add(removeFromDisplay);
		}
		
		private function addToDisplay(node:StarlingRenderNode):void
		{
			container.addChild(node.starlingDisplay.displayObject);
		}
		
		private function removeFromDisplay(node:StarlingRenderNode):void
		{
			container.removeChild(node.starlingDisplay.displayObject);
		}
		
		override public function update(time:Number):void
		{
			var node:StarlingRenderNode;
			var position:Position;
			var displayObject:DisplayObject;
			var starlingDisplay:StarlingDisplay;
			
			for(node = nodes.head; node; node = node.next)
			{
				starlingDisplay = node.starlingDisplay;
				displayObject = starlingDisplay.displayObject;
				position = node.position;
				
				displayObject.x = position.position.x;
				displayObject.y = position.position.y;
				displayObject.rotation = position.rotation;
			}
			
			// manually render the starling
			stage3dProxy.clear();
			starling.nextFrame();
			stage3dProxy.present();
		}

		override public function removeFromGame(game:Game):void
		{
			nodes = null;
			
			// TODO should be handled by starling frame provider
			starling.stop();
			
			starling.dispose();
			starling = null;
		}
		
	}

}