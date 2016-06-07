/**
* BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
* 
* Copyright (c) 2012 BigBlueButton Inc. and by respective authors (see below).
*
* This program is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free Software
* Foundation; either version 3.0 of the License, or (at your option) any later
* version.
* 
* BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
* WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
* PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License along
* with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.
*
*/
package org.bigbluebutton.model.whiteboard
{
  import org.bigbluebutton.model.whiteboard.Annotation;
  import org.bigbluebutton.model.whiteboard.TextObject;
  
  /**
   * The ShapeFactory receives DrawObjects and converts them to Flash Shapes which can then be displayed
   * <p>
   * This approach is necessary because Red5 does not allow Graphical Objects to be stored 
   * in remote shared objects 
   * @author dzgonjan
   * 
   */  
  public class ShapeFactory extends GraphicFactory
  {
    private var _parentWidth:Number = 0;
    private var _parentHeight:Number = 0;
    
    public function ShapeFactory() {
      super(GraphicFactory.SHAPE_FACTORY);
    }
    
    public function setParentDim(width:Number, height:Number):void {
      _parentWidth = width;
      _parentHeight = height;
    }
    
    public function get parentWidth():Number {
      return _parentWidth;
    }
        
    public function get parentHeight():Number {
      return _parentHeight;
    }
        
    public function makeDrawObject(type:String, anID:String, status:String):DrawObject{
		if (type == DrawObject.POLL) {
            return new PollResultObject(anID, type, status);
        }
        return null;
    }
        
//    private function createAnnotation(type:String, shape:Array, color:uint, thickness:uint, fill:Boolean, fillColor:uint, trans:Boolean):DrawAnnotation{
//            
//            return null;
//    }
//            
//    public function createDrawObject(type:String, segment:Array, color:uint, thickness:uint, fill:Boolean, fillColor:uint, transparency:Boolean):DrawAnnotation {
//      var normSegment:Array = new Array();
//      for (var i:int = 0; i < segment.length; i += 2) {
//        normSegment[i] = normalize(segment[i] , _parentWidth);
//        normSegment[i+1] = normalize(segment[i+1], _parentHeight);
//      }
//      return createAnnotation(type, normSegment, color, thickness, fill, fillColor, transparency);
//    }
//	
//	public function redrawTextObject(a:Annotation, t:TextObject):TextObject {
//		//            LogUtil.debug("***Redraw textObject [" + a.type + ", [" + a.annotation.x + "," + a.annotation.y + "]");
//		var tobj:TextObject = new TextObject(a.annotation.text, a.annotation.fontColor,
//			a.annotation.x, a.annotation.y, a.annotation.textBoxWidth, a.annotation.textBoxHeight,
//			a.annotation.fontSize, a.annotation.calcedFontSize);
//		tobj.redrawText(t.oldParentWidth, t.oldParentHeight, _parentWidth,_parentHeight);
//		//            LogUtil.debug("***Redraw textObject [" + tobj.text + ", [" + tobj.x + "," + tobj.y + "," + tobj.textSize + "]");
//		return tobj;
//	}
//	
	public function makeTextObject(t:AnnotationObject):TextObject {
		//            LogUtil.debug("***Making textObject [" + t.type + ", [" + t.annotation.x + "," + t.annotation.y + "]");
		var tobj:TextObject = new TextObject(t.annotation.text, t.annotation.fontColor, 
			t.annotation.x, t.annotation.y, t.annotation.textBoxWidth, 
			t.annotation.textBoxHeight, t.annotation.fontSize, t.annotation.calcedFontSize);
		tobj.makeGraphic(_parentWidth,_parentHeight);
		//            LogUtil.debug("***Made textObject [" + tobj.text + ", [" + tobj.x + "," + tobj.y + "," + tobj.textSize + "]");
		return tobj;
	}
  }
}
