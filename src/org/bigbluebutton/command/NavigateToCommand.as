package org.bigbluebutton.command {
	
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class NavigateToCommand extends Command {
		
		[Inject]
		public var userUISession:IUserUISession;
		
		[Inject]
		public var to:String;
		
		[Inject]
		public var details:Object;
		
		[Inject]
		public var transitionAnimation:int;
		
		override public function execute():void {
			if (to == null || to == "")
				throw new Error("NavigateTo should not be empty");
			if (to == PagesENUM.LAST) {
				userUISession.popPage(transitionAnimation);
			} else {
				userUISession.pushPage(to, details, transitionAnimation);
			}
			trace("NavigateToCommand.execute() - userUISession.currentPage = " + userUISession.currentPage);
		}
	}
}
