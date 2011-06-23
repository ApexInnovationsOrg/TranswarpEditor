package com.apexinnovations.metadata.events {
	import com.apexinnovations.transwarp.data.Page;
	
	import flash.events.Event;
	
	public class PageChangingEvent extends Event {
		
		public static const PAGE_CHANGING:String = "pageChanging";
		
		public var page:Page;
		
		public function PageChangingEvent(page:Page, bubbles:Boolean=false, cancelable:Boolean=false) {
			this.page = page;
			
			super(PAGE_CHANGING, bubbles, cancelable);
		}
	}
}