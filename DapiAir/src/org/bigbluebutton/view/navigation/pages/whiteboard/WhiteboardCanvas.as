package org.bigbluebutton.view.navigation.pages.whiteboard
{
	import spark.components.Group;
	
	public class WhiteboardCanvas extends Group implements IWhiteboardCanvas
	{
		private var _resizeCallback:Function;
		
		public function WhiteboardCanvas()
		{
			super();
		}
		
		public function get resizeCallback():Function {
			return _resizeCallback;
		}
		
		public function set resizeCallback(callback:Function):void {
			_resizeCallback = callback;
		}
		
		public function moveCanvas(x:Number, y:Number, width:Number, height:Number, zoom:Number):void {
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			
			if (_resizeCallback != null)
				callLater(_resizeCallback, [zoom]);
		}
		
		public function dispose():void
		{
		}
	}
}