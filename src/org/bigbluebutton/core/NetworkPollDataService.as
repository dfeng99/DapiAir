package org.bigbluebutton.core
{

  public class NetworkPollDataService implements IPollDataService
  {  
    
    private var sender:PollMessageSender;
          
	public function NetworkPollDataService(sender: PollMessageSender) {
		this.sender = sender;
	}

    public function startCustomPoll(pollId:String, pollType: String, answers: Array):void
    {
      sender.startCustomPoll(pollId, pollType, answers);
    }

    public function startPoll(pollId:String, pollType: String):void
    {
      sender.startPoll(pollId, pollType);
    }
    
    public function stopPoll(pollID:String):void
    {
      sender.stopPoll(pollID);
    }
    
    public function votePoll(pollId:String, answerId:Number):void
    {
      sender.votePoll(pollId, answerId);
    }
    
    public function showPollResult(pollId:String, show:Boolean):void
    {
      sender.showPollResult(pollId, show);
    }
  }
}