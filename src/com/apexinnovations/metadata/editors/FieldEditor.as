package com.apexinnovations.metadata.editors {
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	import com.apexinnovations.metadata.skins.FieldEditorSkin;
	
	[Event(name="focusGained", type="flash.events.Event")]
	public class FieldEditor extends SkinnableContainer {
		
		public function FieldEditor() {
			super();
			setStyle("skinClass", FieldEditorSkin);
			//percentWidth
		}
		
		public static const FOCUS_GAINED:String = "focusGained";
		
		protected var _field:String;
		
		[Bindable] protected var _xml:XML;
		
		[SkinPart(required="true")]
		public var labelDisplay:Label;
		
		protected var _label:String;
		
		[Bindable]
		public function get backgroundColor():uint { return getStyle("backgroundColor");}
		public function set backgroundColor(value:uint):void { setStyle("backgroundColor", value);}
		
		[Bindable]
		public function get label():String { return _label; }
		public function set label(value:String):void { _label = value; updateLabel();}
		
		[Bindable]
		public function get field():String{	return _field; }
		public function set field(value:String):void { _field = value; }
		
		[Bindable]
		public function get xml():XML{ return _xml; }
		public function set xml(value:XML):void { _xml = value;	}
		
		override protected function partAdded(partName:String, instance:Object):void {
			if(partName == "labelDisplay")
				updateLabel();
		}
		
		protected function updateLabel():void {
			if(labelDisplay)
				labelDisplay.text = _label + ":";
		}
	}
}