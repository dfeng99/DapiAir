package org.bigbluebutton.view.navigation.pages.guest {
	
	import spark.components.Button;
	
	public interface IGuestPageView {
		function get currentState():String
		function set currentState(value:String):void
		function get exitButton():Button
	}
}
