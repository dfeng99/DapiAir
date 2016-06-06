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
package org.bigbluebutton.core
{

	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.UserSession;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class PollMessageSender
	{	   
		public var userSession:IUserSession;
		
		private var successSendMessageSignal:ISignal;
		
		private var failureSendingMessageSignal:ISignal;
		
	public function PollMessageSender(userSession:IUserSession, successSendMessageSignal:ISignal, failureSendingMessageSignal:ISignal) {
			this.userSession = userSession;
			this.successSendMessageSignal = successSendMessageSignal;
			this.failureSendingMessageSignal = failureSendingMessageSignal;
	}		
	
	public function startCustomPoll(pollId:String, pollType: String, answers:Array):void
	{
		var header:Object = new Object();		
		header["timestamp"] = (new Date()).time;
		header["name"] = "start_custom_poll_request_message";
		header["version"] = "0.0.1";
		
		var payload:Object = new Object();

		payload["pollType"] = pollType;
		payload["answers"] = answers;
		payload["meetingId"] = UserSession::meetingID();
		payload["pollId"] = pollId;
		payload["requesterId"] = BigBlueButtonConnection::getMyUserId();
		
		var map:Object = new Object();
		map["header"] = header;
		map["payload"] = payload;
		
		var _nc:BigBlueButtonConnection = new BigBlueButtonConnection()
		_nc.sendMessage("poll.sendPollingMessage", 
			function(result:String):void { 
			},	                   
			function(status:String):void {
				trace(status); 
			},
			JSON.stringify(map)
		);
	}
	
    public function startPoll(pollId:String, pollType: String):void
    {
      var map:Object = new Object();
      map["pollId"] = pollId;
      map["pollType"] = pollType;
      
      var _nc:BigBlueButtonConnection = new BigBlueButtonConnection()
      _nc.sendMessage("poll.startPoll", 
        function(result:String):void { 
        },	                   
        function(status:String):void {
			trace(status); 
        },
        map
      );
    }
    
    public function stopPoll(pollId:String):void
    {
      var map:Object = new Object();
      map["pollId"] = pollId;
      
      var _nc:BigBlueButtonConnection = new BigBlueButtonConnection()
      _nc.sendMessage("poll.stopPoll", 
        function(result:String):void { 
        },	                   
        function(status:String):void {
			trace(status); 
        },
        map
      );
    }
    
    public function votePoll(pollId:String, answerId:Number):void
    {
      var map:Object = new Object();
      map["pollId"] = pollId;
      map["answerId"] = answerId;
      
	  userSession.mainConnection.sendMessage("poll.votePoll",
		  function(result:String):void { // On successful result
			  trace('poll result sent!--'+result);
		  },
		  function(status:String):void { // status - On error occurred
			  trace('poll result sent failed--'+status); 
		  },
		  map
	  );
    }
    
    public function showPollResult(pollId:String, show:Boolean):void {
      var map:Object = new Object();
      map["pollId"] = pollId;
      map["show"] = show;
      
      var _nc:BigBlueButtonConnection = new BigBlueButtonConnection()
      _nc.sendMessage("poll.showPollResult", 
        function(result:String):void { 
        },	                   
        function(status:String):void {
			trace(status); 
        },
        map
      );      
    }
	}
}
