package com.apexinnovations.metadata.events {
	import flash.events.Event;
	
	public class RemoveItemEvent extends Event {
		public static const REMOVE_ITEM:String = "removeItem";
		
		public var item:XML;
		
		public function RemoveItemEvent(item:XML, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(REMOVE_ITEM, bubbles, cancelable);
			this.item = item;
		}
	}
}