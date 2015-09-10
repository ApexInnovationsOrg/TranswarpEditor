package com.apexinnovations.metadata.editors {
	import spark.components.SkinnableContainer;
	import com.apexinnovations.metadata.skins.ListItemEditorSkin;
	
	public class ListItemEditor extends SkinnableContainer {
		
		public function ListItemEditor() {
			super();
			setStyle("skinClass", ListItemEditorSkin);
		}
		
		[Bindable]
		protected var _data:XML;
		
		protected var _focus:Boolean;
		
		[Bindable]
		public function get focus():Boolean { return _focus; }
		public function set focus(value:Boolean):void { _focus = value;}
		
		[Bindable]
		public function get data():XML { return _data; }
		public function set data(value:XML):void { _data = value; }
		
		public function initializeAsNewItem():void {}
	}
}