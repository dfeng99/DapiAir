/**
* BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
*
* Copyright (c) 2010 BigBlueButton Inc. and by respective authors (see below).
*
* This program is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free Software
* Foundation; either version 2.1 of the License, or (at your option) any later
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
package org.bigbluebutton.core
{
	import org.bigbluebutton.command.polling.ModelEvent;
	import org.bigbluebutton.command.polling.ModuleEvent;
	import org.bigbluebutton.command.polling.ShowPollResultEvent;
	import org.bigbluebutton.command.polling.StartCustomPollEvent;
	import org.bigbluebutton.command.polling.StartPollEvent;
	import org.bigbluebutton.command.polling.StopPollEvent;
	import org.bigbluebutton.command.polling.VotePollEvent;
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.polling.PollingModel;
	import org.bigbluebutton.model.polling.SimplePoll;
	import org.bigbluebutton.model.presentation.Presentation;
	import org.bigbluebutton.model.presentation.PresentationModel;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;


//	import org.bigbluebutton.model.presentation.Presentation;
//	import org.bigbluebutton.model.presentation.PresentationModel;

	public class PollingService implements IPollingService
	{	  
    	private var model:PollingModel;
    	private var pollSender:PollMessageSender;
		private var dataProcessor:PollDataProcessor;
		private var pollReceiver:PollMessageReceiver;
		
		[Inject]
		private var dataService:IPollDataService;
		
		[Inject]
		public var userSession:IUserSession;
		
		private var _sendMessageOnSuccessSignal:ISignal = new Signal();
		private var _sendMessageOnFailureSignal:ISignal = new Signal();
		
		public function PollingService(userSession:IUserSession):void {
			trace("Initiating Polling service...");
			this.userSession = userSession == null ? this.userSession : userSession;
		}
		
		public function setupMessageSenderReceiver():void  {
			model = new PollingModel();
			dataProcessor = new PollDataProcessor(model);
			pollSender = new PollMessageSender(userSession, _sendMessageOnSuccessSignal, _sendMessageOnFailureSignal);
			dataService = new NetworkPollDataService(pollSender);
			pollReceiver = new PollMessageReceiver(userSession, dataProcessor);
			if(userSession != null) this.userSession = userSession;
			 userSession.mainConnection..addMessageListener(pollReceiver as IMessageListener);
		}
	public function handleStartModuleEvent(event:ModuleEvent):void {
			trace("polling started event");
	}
	public function handleModuleEvent(event:ModuleEvent):void {
		trace("polling started event");
	}
    private function generatePollId():String {
	  var curPres:Presentation = PresentationModel.getInstance().getCurrentPresentation();
      if (curPres != null) {
        var date:Date = new Date();
       var pollId: String = curPres.id + "/" + curPres.currentSlideNum + "/" + date.time;
        return pollId;
      }
      
      return null;
    }

    public function handleStartCustomPollEvent(event:StartCustomPollEvent):void {
      var pollId:String = generatePollId();
      if (pollId == null) return;
      dataService.startCustomPoll(pollId, event.pollType, event.answers);
     }

   public function handleStartPollEvent(event:StartPollEvent):void {
      var pollId:String = generatePollId();
      if (pollId == null) return;
      dataService.startPoll(pollId, event.pollType);
    }
   
   public function handleModelEvent(event:ModelEvent):void {
	   model = new PollingModel();
	   model.setCurrentPoll(event.poll);
   }
    public function handleStopPollEvent(event:StopPollEvent):void {	
      var curPoll:SimplePoll = model.getCurrentPoll();
      dataService.stopPoll(curPoll.id);
    }
    
    public function handleVotePollEvent(event:VotePollEvent):void {
	  pollSender = new PollMessageSender(userSession, _sendMessageOnSuccessSignal, _sendMessageOnFailureSignal);
	  dataService = new NetworkPollDataService(pollSender);			
      var curPoll:SimplePoll = model.getCurrentPoll();
      dataService.votePoll(curPoll.id, event.answerId);
    }
    
    public function handleShowPollResultEvent(event:ShowPollResultEvent):void {
      var curPoll:SimplePoll = model.getCurrentPoll();
      dataService.showPollResult(curPoll.id, event.show);
    }
    

	}
}