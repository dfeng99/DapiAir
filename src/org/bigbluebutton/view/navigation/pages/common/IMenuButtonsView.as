package org.bigbluebutton.view.navigation.pages.common {
	
	import org.bigbluebutton.view.ui.NavigationButton;
	import spark.components.Button;
	
	public interface IMenuButtonsView {
		function get menuDeskshareButton():NavigationButton
		function get menuVideoChatButton():NavigationButton
		function get menuPresentationButton():NavigationButton
		function get menuChatButton():NavigationButton
		function get menuParticipantsButton():NavigationButton
		function get pushToTalkButton():Button;
	}
}
