package net.richardlord.asteroids.systems
{
	import away3d.core.managers.Stage3DProxy;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.components.StarlingDisplay;
	import net.richardlord.asteroids.nodes.StarlingRenderNode;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	
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
		
		
		public function StarlingRenderSystem(starling:Starling, stage3dproxy:Stage3DProxy)
		{
			this.container = starling.root as DisplayObjectContainer;
			this.starling = starling;
			this.stage3dProxy = stage3dproxy;
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
		}
		
	}

}