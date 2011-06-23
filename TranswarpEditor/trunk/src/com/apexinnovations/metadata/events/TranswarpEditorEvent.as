package com.apexinnovations.metadata.events {
	import flash.events.Event;
	
	public class TranswarpEditorEvent extends Event {
		
		public static const FIELD_VALUE_CHANGE:String = "fieldValueChange";
		public static const SAVE_PAGE:String = "savePage";
		public static const COMMIT_PENDING_SELECTION:String = "commitPendingSelection";
		public static const CANCEL_PENDING_SELECTION:String = "cancelPendingSelection";
		
		
		public function TranswarpEditorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}