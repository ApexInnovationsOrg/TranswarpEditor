package com.apexinnovations.metadata.controls {
	import flash.events.MouseEvent;
	
	import mx.core.IVisualElement;
	
	import spark.components.Group;
	
	public class HoverGroup extends Group {
		
		protected var _normal:IVisualElement;
		protected var _hovered:IVisualElement;

		protected var over:Boolean = false;
		protected var _lockHover:Boolean = false;
		
		public function HoverGroup() {
			super();
			
			addEventListener(MouseEvent.ROLL_OUT, handleMouse);
			addEventListener(MouseEvent.ROLL_OVER, handleMouse);
		}
		
		protected function handleMouse(event:MouseEvent):void {
			var value:Boolean = event.type == MouseEvent.ROLL_OVER;
			if(value == over)
				return;
			
			over = value;
			invalidateDisplayList();				
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			var state:Boolean = _lockHover || over;
			if(normal) {
				normal.visible = !state;
			}
			
			if(hovered) {
				hovered.visible = state;
			}
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
	
		
		public function get normal():IVisualElement { return _normal; }

		public function set normal(value:IVisualElement):void { 	
			_normal = value;
			if(_normal) {
				addElement(_normal);
				invalidateDisplayList();
			}
		}

		public function get hovered():IVisualElement { return _hovered; }

		public function set hovered(value:IVisualElement):void {
			_hovered = value;
			if(_hovered) {
				addElement(_hovered);
				invalidateDisplayList();
			}
		}

		public function get lockHover():Boolean { return _lockHover; }
		public function set lockHover(value:Boolean):void { _lockHover = value;	invalidateDisplayList();}


	}
}