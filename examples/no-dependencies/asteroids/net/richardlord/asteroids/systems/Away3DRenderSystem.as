package net.richardlord.asteroids.systems
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DProxy;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.components.Display;
	import net.richardlord.asteroids.components.Display3D;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.Away3DRenderNode;

	
	public class Away3DRenderSystem extends System
	{
		public var view3D:View3D;
		public var stage3dProxy:Stage3DProxy;
		
		private var nodes:NodeList;
		private var _scene:Scene3D;
		
		public function Away3DRenderSystem(view3D:View3D, stage3dproxy:Stage3DProxy)
		{
			this.view3D = view3D;
			this.stage3dProxy = stage3dproxy;
			
			_scene = view3D.scene;
		}
		
		override public function addToGame(game:Game):void
		{
			// init camera
			view3D.camera.z = -240;
			view3D.camera.y = 120;
			view3D.camera.x = 160;
			
			nodes = game.getNodeList(Away3DRenderNode);
			for(var node:Away3DRenderNode = nodes.head; node; node = node.next)
			{
				addToDisplay(node);
			}
			nodes.nodeAdded.add(addToDisplay);
			nodes.nodeRemoved.add(removeFromDisplay);
		}
		
		private function addToDisplay(node:Away3DRenderNode):void
		{
			_scene.addChild(node.display3D.object3D);
		}
		
		private function removeFromDisplay(node:Away3DRenderNode):void
		{
			_scene.removeChild(node.display3D.object3D);
		}
		
		override public function update(time:Number):void
		{
			var node:Away3DRenderNode;
			var position:Position;
			var display3D:Display3D;
			var object3D:ObjectContainer3D;
			for(node = nodes.head; node; node = node.next)
			{
				display3D = node.display3D;
				object3D = display3D.object3D;
				position = node.position;
				
				object3D.x = position.position.x;
				object3D.y = position.position.y;
				object3D.rotationZ = position.rotation * 180 / Math.PI;
			}
			
			// render the view
			stage3dProxy.clear();
			view3D.render();
			stage3dProxy.present();
		}

		override public function removeFromGame(game:Game):void
		{
			nodes = null;
		}
	}
}
