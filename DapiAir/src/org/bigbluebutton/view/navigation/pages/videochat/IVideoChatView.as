package org.bigbluebutton.view.navigation.pages.videochat {
	
	import flash.media.Video;
	import flash.net.NetConnection;
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.Scroller;
	import spark.components.VideoDisplay;
	
	public interface IVideoChatView extends IView {
		function stopStream():void
		function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number, screenHeight:Number, screenWidth:Number):void
		function get noVideoMessage():Label
		function getDisplayedUserID():String
		function get videoGroup():Group
		function get streamlist():List
		function get streamListScroller():Scroller
		function get videoStream():VideoDisplay
		function get video():Video
	}
}
