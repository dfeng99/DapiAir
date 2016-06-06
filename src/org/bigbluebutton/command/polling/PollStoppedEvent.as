package org.bigbluebutton.command.polling
{
  import flash.events.Event;
  
  public class PollStoppedEvent extends Event
  {
    public static const POLL_STOPPED:String = "poll stopped";
        
    public function PollStoppedEvent()
    {
      super(POLL_STOPPED, true, false);
    }
  }
}