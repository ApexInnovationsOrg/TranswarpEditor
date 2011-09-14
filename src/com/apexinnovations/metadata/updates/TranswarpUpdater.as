package com.apexinnovations.metadata.updates {
	import air.update.ApplicationUpdaterUI;
	import air.update.events.DownloadErrorEvent;
	import air.update.events.StatusUpdateErrorEvent;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	
	public class TranswarpUpdater extends EventDispatcher {
		
		protected var updater:ApplicationUpdaterUI;
		
		public function TranswarpUpdater(){
			super();
			
			updater = new ApplicationUpdaterUI();
			updater.isDownloadUpdateVisible = false;
			updater.isCheckForUpdateVisible = false;
			updater.isInstallUpdateVisible = false;
			
			updater.updateURL = "http://www.apexsandbox.com/Classroom/engine/editor/update.xml";
			
			updater.addEventListener(UpdateEvent.INITIALIZED, initialized);
			updater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, updateStatus);
			updater.addEventListener(ErrorEvent.ERROR, onError);
			updater.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, onError);
			updater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, onError);
			updater.initialize();
		}
		
		protected function updateStatus(event:StatusUpdateEvent):void {
			trace(event.version);
			trace(event.versionLabel);
			if(!event.available)
				dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function onError(event:ErrorEvent):void {
			dispatchEvent(new Event(Event.COMPLETE));
			trace(event);
			
		}
		
		protected function initialized(event:UpdateEvent):void {
			updater.checkNow();
		}
	}
}