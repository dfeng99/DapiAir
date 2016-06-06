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

//  import org.bigbluebutton.core.BigBlueButtonConnection;
  
  import com.asfusion.mate.events.Dispatcher;
  
  import org.bigbluebutton.command.polling.ModuleEvent;
  import org.bigbluebutton.model.IMessageListener;
  import org.bigbluebutton.model.IUserSession;

  public class PollMessageReceiver implements IMessageListener
  {    
	private var dispatcher:Dispatcher = new Dispatcher();	  
    private var processor:PollDataProcessor;
	private var userSession:IUserSession;
	
    public function PollMessageReceiver(userSession:IUserSession, processor:PollDataProcessor) {
		this.userSession = userSession;
		this.processor = processor;
    }

    public function onMessage(messageName:String, message:Object):void {
//      LOGGER.debug("received message {0}", [messageName]);

      switch (messageName) {
        case "pollShowResultMessage":
          processor.handlePollShowResultMessage(message);
          break;
        case "pollStartedMessage":
		  dispatcher.dispatchEvent(new ModuleEvent(userSession));
          processor.handlePollStartedMesage(message);
          break;
        case "pollStoppedMessage":
          processor.handlePollStoppedMesage(message);
          break;
        case "pollUserVotedMessage":
          processor.handlePollUserVotedMessage(message);
          break;
      }
    }
  }
}