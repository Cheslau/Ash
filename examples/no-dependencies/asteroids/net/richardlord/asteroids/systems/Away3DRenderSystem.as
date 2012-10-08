package net.richardlord.asteroids.systems
{
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.components.Display;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.RenderNode;

	
	public class Away3DRenderSystem extends System
	{
		public var view3D:View3D;
		
		private var nodes:NodeList;
		private var _scene:Scene3D;
		
		public function Away3DRenderSystem(view3D:View3D)
		{
			this.view3D = view3D;
			
			_scene = view3D.scene;
		}
		
		override public function addToGame(game:Game):void
		{
			// TODO replace this with Render3DNode
			/*
			nodes = game.getNodeList(RenderNode);
			for(var node:RenderNode = nodes.head; node; node = node.next)
			{
				addToDisplay(node);
			}
			nodes.nodeAdded.add(addToDisplay);
			nodes.nodeRemoved.add(removeFromDisplay);
			*/
		}
		
		private function addToDisplay(node:RenderNode):void
		{
			// TODO replace this with Render3DNode
			//container.addChild(node.display.displayObject);
		}
		
		private function removeFromDisplay(node:RenderNode):void
		{
			// TODO replace this with Render3DNode
			//container.removeChild(node.display.displayObject);
		}
		
		override public function update(time:Number):void
		{
			// TODO replace this with Render3DNode
			/*
			var node:RenderNode;
			var position:Position;
			var display:Display;
			var displayObject:DisplayObject;
			
			for(node = nodes.head; node; node = node.next)
			{
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;
				
				displayObject.x = position.position.x;
				displayObject.y = position.position.y;
				displayObject.rotation = position.rotation * 180 / Math.PI;
			}
			*/
		}

		override public function removeFromGame(game:Game):void
		{
			nodes = null;
		}
	}
}
