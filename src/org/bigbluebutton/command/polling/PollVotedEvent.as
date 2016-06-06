package org.bigbluebutton.command.polling
{
  import flash.events.Event;
  
  import org.bigbluebutton.model.polling.SimplePollResult;
  
  public class PollVotedEvent extends Event
  {
    public static const POLL_VOTED:String = "poll voted";
    
    public var result:SimplePollResult;
    
    public function PollVotedEvent(result:SimplePollResult)
    {
      super(POLL_VOTED, true, false);
      this.result = result;
    }
  }
}