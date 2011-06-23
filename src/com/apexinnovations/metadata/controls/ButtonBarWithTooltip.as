package com.apexinnovations.metadata.controls {
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.effects.IAbstractEffect;
	import mx.managers.IToolTipManagerClient;
	
	import spark.components.ButtonBar;
	import spark.components.IItemRenderer;
	import spark.utils.LabelUtil;
	
	public class ButtonBarWithTooltip extends ButtonBar {
		
		protected var tooltipFieldOrFunctionChanged:Boolean = true;		
		protected var _toolTipField:String = "toolTip";
		protected var _toolTipFunction:Function;
		
		public function ButtonBarWithTooltip() {
			super();
		}
		
		public function get toolTipFunction():Function {
			return _toolTipFunction;
		}
		
		public function set toolTipFunction(value:Function):void {
			_toolTipFunction = value;
			tooltipFieldOrFunctionChanged = true;
			invalidateProperties();
		}
		
		public function get toolTipField():String{
			return _toolTipField;
		}

		public function set toolTipField(value:String):void	{
			_toolTipField = value;
			tooltipFieldOrFunctionChanged = true;
			invalidateProperties();
		}
			
		protected function updateRendererTooltips():void {
			if (!dataGroup)
				return;
			
			const count:int = dataGroup.numElements;
			for (var i:int = 0; i < count; i++) {
				var renderer:IItemRenderer = dataGroup.getElementAt(i) as IItemRenderer;
				if (renderer && renderer.data)
					itemToToolTip(renderer as IToolTipManagerClient, renderer.data);
			}	
		}	
				
		
		protected function itemToToolTip(renderer:IToolTipManagerClient, data:Object):void {
			if(renderer)
				renderer.toolTip = LabelUtil.itemToLabel(data, _toolTipField, _toolTipFunction);
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			if(tooltipFieldOrFunctionChanged)
				updateRendererTooltips();
			
		}
		
		override public function updateRenderer(renderer:IVisualElement, itemIndex:int, data:Object):void {
			super.updateRenderer(renderer, itemIndex, data);
			if(renderer is IToolTipManagerClient)
				itemToToolTip(renderer as IToolTipManagerClient, data);
		}	
	}
}