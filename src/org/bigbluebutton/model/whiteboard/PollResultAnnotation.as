package org.bigbluebutton.model.whiteboard {
	
	import spark.components.RichText;
	
	import flashx.textLayout.formats.VerticalAlign;
	
	import org.bigbluebutton.model.whiteboard.DrawObject;
	import org.bigbluebutton.model.whiteboard.ShapeFactory;
	import org.bigbluebutton.model.whiteboard.TextAnnotation;
	import org.bigbluebutton.view.navigation.pages.whiteboard.IWhiteboardCanvas;
	
	public class PollResultAnnotation extends Annotation {
		private var _pollResultObj:DrawObject;
		private var shapeFactory:ShapeFactory = new ShapeFactory();;
		private var zoomPercentage:Number = 1;
		private var _annotation: Object;
		private var _legacyAn:AnnotationObject;
		private var _text:String;
		private var _fontSize:Number;
		private var _fontColor:Number;
		private var _textBoxHeight:Number;
		private var _textBoxWidth:Number;
		private var _richText:RichText;
		private var _x:Number;
		private var _y:Number;
		
		public function PollResultAnnotation(an:Object) {
			super(an.type, an.id, an.shape == null ? an.shapes.whiteboardId : an.shape.whiteboardId, an.status, 0x000000);
			_pollResultObj = shapeFactory.makeDrawObject(an.type, an.id, an.status);
			this._annotation = an;
			_text="Vote Result:";
			_fontSize = 18;
			_fontColor = 0x000000;
			_legacyAn = an2Legacy(an);
			_x = 0;
			_y = 0;
		}
		
		override public function update(an:IAnnotation):void {
			trace("update result do nothing");
		}
		
		override public function draw(canvas:IWhiteboardCanvas, zoom:Number):void {
			shapeFactory.setParentDim(canvas.width,canvas.height);
			if ( _annotation.type != DrawObject.TEXT) {
					_pollResultObj.draw(_legacyAn, shapeFactory.parentWidth, shapeFactory.parentHeight, zoomPercentage);        
			} else { 
				if (_annotation.annotation.text != "") {
					addNormalText(canvas, _legacyAn);
				}
			}

			if ( !canvas.containsElement(_pollResultObj) ) {
				canvas.addElement(_pollResultObj);
			}
		}
		
		private function an2Legacy(an:Object):AnnotationObject{
			return new AnnotationObject(an.anID, an.type, an);
		}
		
		/* adds a new TextObject that is suited for a viewer. For example, it will not
		be made editable and no listeners need to be attached because the viewers
		should not be able to edit/modify the TextObject 
		*/
		private function addNormalText(canvas:IWhiteboardCanvas, o:AnnotationObject):void {
			if (!_richText) {
				_richText = new RichText();
			}
			_textBoxHeight = TextAnnotation(o).textBoxHeight;
			_textBoxWidth = TextAnnotation(o).textBoxWidth;
			_richText.text = _text;
			trace("text: = " + _text);
			_richText.setStyle("fontSize", _fontSize);
			_richText.setStyle("fontFamily", "Arial");
			_richText.setStyle("color", _fontColor);
			_richText.setStyle("verticalAlign", VerticalAlign.TOP);
			_richText.x = denormalize(_x, canvas.width);
			_richText.y = denormalize(_y, canvas.height);
			_richText.width = denormalize(_textBoxWidth, canvas.width);
			_richText.height = denormalize(_textBoxHeight, canvas.height);
			if (!canvas.containsElement(_richText)) {
				canvas.addElement(_richText);
			}
		}
		
		override public function remove(canvas:IWhiteboardCanvas):void {
			if (canvas.containsElement(_pollResultObj)) {
				canvas.removeElement(_pollResultObj);
			}
		}
	}
}
