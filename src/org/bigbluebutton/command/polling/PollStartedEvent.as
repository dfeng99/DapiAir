package org.bigbluebutton.command.polling
{
  import flash.events.Event;
  
  import org.bigbluebutton.model.polling.SimplePoll;
  
  public class PollStartedEvent extends Event
  {
    public static const POLL_STARTED:String = "poll started";
    
    public var poll:SimplePoll;
    
    public function PollStartedEvent(poll:SimplePoll)
    {
      super(POLL_STARTED, true, false);
      this.poll = poll;
    }
  }
}