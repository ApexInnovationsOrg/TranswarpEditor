package com.apexinnovations.metadata {
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.ElementRange;
	import flashx.textLayout.edit.IEditManager;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowGroupElement;
	import flashx.textLayout.elements.FlowLeafElement;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.ListElement;
	import flashx.textLayout.elements.ListItemElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.SelectionEvent;
	import flashx.textLayout.formats.BaselineShift;
	import flashx.textLayout.formats.ITextLayoutFormat;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextDecoration;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.undo.UndoManager;
	
	import mx.controls.List;
	
	import spark.components.TextArea;
	import spark.components.TextSelectionHighlighting;
	
	public class TextEditorTextArea extends TextArea {
		
		public function TextEditorTextArea() {
			super();
			textFlow = new TextFlow();
			selectionHighlighting = TextSelectionHighlighting.ALWAYS;
			minHeight = 0;
		}
		
		protected var _bold:Boolean = false;
		protected var _underline:Boolean = false;
		protected var _italic:Boolean = false;
		protected var _list:Boolean = false;
		protected var _align:String = TextAlign.LEFT;
		protected var _color:uint = 0;
		protected var _fontSize:uint = 12;
		protected var _fontFamily:*;
		protected var _listStyleType:String;
		protected var _strikethrough:Boolean;
		protected var _superscript:Boolean;
		protected var _subscript:Boolean;
		protected var _link:String;
		
		[Bindable("formatChanged")]	public function get italic():Boolean {return _italic;}
		[Bindable("formatChanged")]	public function get underline():Boolean	{return _underline;}
		[Bindable("formatChanged")]	public function get bold():Boolean {return _bold;}
		[Bindable("formatChanged")] public function get list():Boolean {return _list;}		
		[Bindable("formatChanged")] public function get align():String {return _align;}
		[Bindable("formatChanged")] public function get color():uint {return _color;}
		[Bindable("formatChanged")] public function get fontSize():uint { return _fontSize; }
		[Bindable("formatChanged")] public function get fontFamily():* { return _fontFamily; }
		[Bindable("formatChanged")] public function get listStyleType():String { return _listStyleType; }
		[Bindable("formatChanged")] public function get strikethrough():Boolean	{ return _strikethrough; }
		[Bindable("formatChanged")] public function get superscript():Boolean { return _superscript; }
		[Bindable("formatChanged")] public function get subscript():Boolean { return _subscript; }
		[Bindable("formatChanged")] public function get link():String { return _link; }
		
		public function set bold(value:Boolean):void {
			applyLeafFormat("fontWeight", value ? FontWeight.BOLD : FontWeight.NORMAL);
		}
		
		public function set underline(value:Boolean):void {
			applyLeafFormat("textDecoration", value ? TextDecoration.UNDERLINE : TextDecoration.NONE);
		}
		
		public function set italic(value:Boolean):void {
			applyLeafFormat("fontStyle", value ? FontPosture.ITALIC : FontPosture.NORMAL);
		}
		
		public function set align(value:String):void {
			applyParagraphFormat("textAlign", value);
		}
		
		public function set color(value:uint):void {
			applyLeafFormat("color", value);
			textFlow.interactionManager.setFocus();
		}
		
		public function set fontFamily(value:*):void {
			applyLeafFormat("fontFamily", value is Font ? Font(value).fontName : value);
		}
		
		public function set strikethrough(value:Boolean):void		{
			applyLeafFormat("lineThrough", value);			
		}
		
		public function set superscript(value:Boolean):void {
			applyLeafFormat("baselineShift", value ? BaselineShift.SUPERSCRIPT : 0);
		}
		
		public function set subscript(value:Boolean):void {
			applyLeafFormat("baselineShift", value ? BaselineShift.SUBSCRIPT : 0);	
		}
		
		public function set link(value:String):void {
			if(value == "") {
				var edit:EditManager = textFlow.interactionManager as EditManager;
				if(edit.isRangeSelection()) {
					edit.applyLink(null, null, true);
				} else {
					edit.beginCompositeOperation();
					var position:int = edit.absoluteStart;
					edit.selectRange(position, position+1);
					edit.applyLink(null, null, true);
					edit.selectRange(position, position);
					edit.endCompositeOperation();
				}
			} else
				EditManager(textFlow.interactionManager).applyLink(value, "_blank", true);
		}
		
		public function set listStyleType(value:String):void {
			if(!_list)
				return;
			
			var edit:EditManager = textFlow.interactionManager as EditManager;
			var range:ElementRange = ElementRange.createElementRange(textFlow, edit.absoluteStart, edit.absoluteEnd);
			var list:ListElement = range.firstLeaf.getParentByType(ListElement) as ListElement;
			
			if(!list)
				return;
			
			list.listStyleType = value;
		}
		
		public function set list(value:Boolean):void {
			var edit:EditManager = textFlow.interactionManager as EditManager;
			
			if(value)
				edit.createList();
			else {
				var range:ElementRange = ElementRange.createElementRange(textFlow, edit.absoluteStart, edit.absoluteEnd);
				var list:ListElement = range.firstLeaf.getParentByType(ListElement) as ListElement;
				if(list)
					edit.moveChildren(list,0,list.numChildren,list.parent,list.parent.getChildIndex(list));
			}
		}
		
		public function set fontSize(value:uint):void {
			applyLeafFormat("fontSize", value);
		}		
		
		public override function set textFlow(value:TextFlow):void {
			if(value == null)
				value = new TextFlow();
			super.textFlow = value;
			textFlow.interactionManager = new EditManager(new UndoManager());
			textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE, selectionChange, false, 0, true);
		}
		
		protected function selectionChange(e:SelectionEvent):void {
			var selectionState:SelectionState = e.selectionState;
			var selectedElementRange:ElementRange = ElementRange.createElementRange(textFlow, selectionState.absoluteStart, selectionState.absoluteEnd);
					
			var characterFormat:ITextLayoutFormat = selectedElementRange.getCommonCharacterFormat();
			var paragraphFormat:ITextLayoutFormat = selectedElementRange.getCommonParagraphFormat();
			var containerformat:ITextLayoutFormat = selectedElementRange.getCommonContainerFormat();
				
			_bold = characterFormat.fontWeight == FontWeight.BOLD;
			_underline = characterFormat.textDecoration == TextDecoration.UNDERLINE;
			_italic = characterFormat.fontStyle == FontPosture.ITALIC;
			_list = checkForList(selectedElementRange);
			_color = characterFormat.color;
			_fontSize = characterFormat.fontSize;
			_fontFamily = characterFormat.fontFamily;
			_strikethrough = characterFormat.lineThrough;
			_superscript = characterFormat.baselineShift == BaselineShift.SUPERSCRIPT;
			_subscript = characterFormat.baselineShift == BaselineShift.SUBSCRIPT;
			
			var link:LinkElement = selectedElementRange.firstLeaf.getParentByType(LinkElement) as LinkElement;
			if(link)
				_link = link.href;
			else
				_link = "";
			
			var list:ListElement = selectedElementRange.firstLeaf.getParentByType(ListElement) as ListElement;
			if(list)
				_listStyleType = list.listStyleType;
			
			if(_listStyleType == null)
				_listStyleType = "disc";
						
			//Pretend that START and END are equivalent to LEFT and RIGHT respectively to simplify UI
			if(paragraphFormat.textAlign == TextAlign.START)
				_align = TextAlign.LEFT;
			else if(paragraphFormat.textAlign == TextAlign.END)
				_align = TextAlign.RIGHT;
			else			
				_align = paragraphFormat.textAlign;
			
			dispatchEvent(new Event("formatChanged"));
		}
		
		protected function checkForList(range:ElementRange):Boolean {		
			var currentLeaf:FlowLeafElement = range.firstLeaf;
			var prevLeaf:FlowLeafElement;
			
			do {
				var list:ListElement = currentLeaf.getParentByType(ListElement) as ListElement;
				if(!list)
					return false;
				prevLeaf = currentLeaf;
				currentLeaf = currentLeaf.getNextLeaf();
			} while(currentLeaf != null && prevLeaf != range.lastLeaf)
			
			return true;
		}
			
				
		protected function includeInList(p:ParagraphElement, list:ListElement):void {
			p.parent.removeChild(p);
			var li:ListItemElement = new ListItemElement();
			li.addChild(p);
			list.addChild(li);
		}		
			
		protected function applyLeafFormat(field:String, value:*):void {
			var fmt:TextLayoutFormat = new TextLayoutFormat();
			fmt[field] = value;
			IEditManager(textFlow.interactionManager).applyLeafFormat(fmt);
		}			
				
		protected function applyParagraphFormat(field:String, value:String):void {
			var fmt:TextLayoutFormat = new TextLayoutFormat();
			fmt[field] = value;
			IEditManager(textFlow.interactionManager).applyParagraphFormat(fmt);
		}
		
	}
}
