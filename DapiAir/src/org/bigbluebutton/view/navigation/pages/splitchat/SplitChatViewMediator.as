package org.bigbluebutton.view.navigation.pages.splitchat {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.utils.setTimeout;
	import mx.core.FlexGlobals;
	import mx.events.ItemClickEvent;
	import mx.events.ResizeEvent;
	import mx.resources.ResourceManager;
	import mx.utils.ObjectUtil;
	import org.bigbluebutton.command.ClearUserStatusSignal;
	import org.bigbluebutton.command.MoodSignal;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.bigbluebutton.view.navigation.pages.splitsettings.SplitViewEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import spark.events.IndexChangeEvent;
	
	public class SplitChatViewMediator extends Mediator {
		
		[Inject]
		public var view:ISplitChatView;
		
		[Inject]
		public var userUISession:IUserUISession;
		
		private var currentChat:Object = null;
		
		override public function initialize():void {
			eventDispatcher.addEventListener(SplitViewEvent.CHANGE_VIEW, changeView);
			view.participantsList.pushView(PagesENUM.getClassfromName(PagesENUM.CHATROOMS));
			FlexGlobals.topLevelApplication.stage.addEventListener(ResizeEvent.RESIZE, stageOrientationChangingHandler);
		}
		
		private function stageOrientationChangingHandler(e:Event):void {
			var tabletLandscape = FlexGlobals.topLevelApplication.isTabletLandscape();
			if (currentChat) {
				if (tabletLandscape) {
					userUISession.pushPage(PagesENUM.SPLITCHAT, currentChat);
				} else {
					if (currentChat.hasOwnProperty("button")) {
						userUISession.pushPage(PagesENUM.SELECT_PARTICIPANT, userUISession.currentPageDetails);
					} else {
						userUISession.pushPage(PagesENUM.CHAT, currentChat);
					}
				}
			}
		}
		
		private function changeView(event:SplitViewEvent) {
			view.participantDetails.pushView(event.view);
			currentChat = event.details;
			userUISession.pushPage(PagesENUM.SPLITCHAT, event.details)
		}
		
		override public function destroy():void {
			super.destroy();
			eventDispatcher.removeEventListener(SplitViewEvent.CHANGE_VIEW, changeView);
			FlexGlobals.topLevelApplication.stage.removeEventListener(ResizeEvent.RESIZE, stageOrientationChangingHandler);
			view.dispose();
			view = null;
		}
	}
}
