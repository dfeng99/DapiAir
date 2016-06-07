package org.bigbluebutton.model.whiteboard {
	
	public class AnnotationObject {
		private var _id:String = "undefined";
		private var _status:String = AnnotationStatus.DRAW_START;
		private var _type:String = "undefined";
		private var _annotation:Object;
		
		public function AnnotationObject(id:String, type:String, annotation:Object) {
			_id = id;
			_type = type;
			_annotation = annotation;
		}
		
		public function get type():String{
			return _type;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get annotation():Object {
			return _annotation;
		}
		
		public function set annotation(a:Object):void {
			_annotation = a;
		}
		
		public function get status():String {
			return _status;
		}
		
		public function set status(s:String):void {
			_status = s;
		}
		
		public function get whiteboardId():String {
			return _annotation.whiteboardId;
		}
		
		public function get pageNumber():Number {
			return _annotation.pageNumber;
		}
	}
}
