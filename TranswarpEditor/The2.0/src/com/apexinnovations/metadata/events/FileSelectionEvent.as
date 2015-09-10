package com.apexinnovations.metadata.events {
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class FileSelectionEvent extends Event {
		
		public static const FILE_SELECTION:String = "fileSelection";
		
		public var file:File;
		
		public function FileSelectionEvent(file:File, bubbles:Boolean=false, cancelable:Boolean=false) {
			this.file = file;
			super(FILE_SELECTION, bubbles, cancelable);
		}
	}
}