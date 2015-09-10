package com.apexinnovations.metadata {
	public class EditorConfig {
		
		protected var _repoPath:String = "";
		protected var _selectedProduct:String = "IMPULSE";
		
		public function EditorConfig(xml:XML=null) {
			if(xml)
				this.xml = xml;
			else
				resetToDefault();
		}
		
		public function set xml(xml:XML):void {
			if(xml.repoPath[0])
				repoPath = xml.repoPath[0].@value;
			if(xml.selectedProduct[0])
				selectedProduct = xml.selectedProduct[0].@value;
		}
		
		public function get xml():XML {
			return <TranswarpEditorConfiguration>
				<repoPath value={_repoPath} />
				<selectedProduct value={selectedProduct} />
			</TranswarpEditorConfiguration>;
		}
		
		public function resetToDefault():void {
			xml = <TranswarpEditorConfiguration />;
		}
		
		[Bindable] public function get repoPath():String { return _repoPath; }
		public function set repoPath(value:String):void { _repoPath = value; }

		[Bindable] public function get selectedProduct():String {return _selectedProduct;}
		public function set selectedProduct(value:String):void {_selectedProduct = value;}

	}
}