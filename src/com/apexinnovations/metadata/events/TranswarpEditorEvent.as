package com.apexinnovations.metadata.events {
	import flash.events.Event;
	
	public class TranswarpEditorEvent extends Event {
		
		public static const FIELD_VALUE_CHANGE:String = "fieldValueChange"; // fired from field editors when they change value
		
		//public static const SAVING_PAGE:String = "savingPage"; // Fired immediately before saving a page.  this is the last chance to make changes to the xml before it is saved
		public static const SAVE_PAGE:String = "savePage";		// Fired to tell the application that it is time to save the page
		
		public static const COMMIT_PENDING_SELECTION:String = "commitPendingSelection"; 
		public static const CANCEL_PENDING_SELECTION:String = "cancelPendingSelection";
		
		public static const FIELD_CREATED:String = "fieldCreated"; // Fired in the added_to_stage handler of all fieldeditors.  used to "discover" them within the page editor
		
		public function TranswarpEditorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}