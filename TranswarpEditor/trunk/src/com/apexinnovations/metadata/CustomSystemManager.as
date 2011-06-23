package com.apexinnovations.metadata {
	import flashx.textLayout.container.TextContainerManager;
	
	import mx.managers.SystemManager;
	
	/**
	 * Custom SystemManager class that forces the textLayout classes to be compiled into frame 1
	 */
	public class CustomSystemManager extends SystemManager {
		public function CustomSystemManager() {
			var c:Class = TextContainerManager;
			super();
		}
	}
}