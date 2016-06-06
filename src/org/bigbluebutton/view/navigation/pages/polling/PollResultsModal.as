package org.bigbluebutton.view.navigation.pages.polling
{
	import com.asfusion.mate.events.Dispatcher;
	import com.asfusion.mate.events.Listener;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import spark.components.HGroup;
	import spark.components.TitleWindow;
	import spark.components.Button;
	import spark.primitives.Line;
	import spark.components.Label;
	import spark.components.TextArea;
//	import mx.core.ScrollPolicy;
	import mx.managers.PopUpManager;
	
	import org.bigbluebutton.command.polling.PollStoppedEvent;
	import org.bigbluebutton.command.polling.PollVotedEvent;
	import org.bigbluebutton.command.polling.ShowPollResultEvent;
	import org.bigbluebutton.command.polling.StopPollEvent;
	import org.bigbluebutton.model.polling.SimpleAnswer;
//	import org.bigbluebutton.model.polling.SimpleAnswerResult;
	import org.bigbluebutton.model.polling.SimplePoll;
	import mx.resources.ResourceManager;
	
	public class PollResultsModal extends TitleWindow {
		private var _voteListener:Listener;
		private var _stopPollListener:Listener;
		
		private var _respondersLabel:Label;
		private var _respondersLabelDots:Label;
		private var _pollGraphic:PollGraphic;
		private var _publishBtn:Button;
		private var _closeBtn:Button;
		
		private var _dotTimer:Timer;
		
		public function PollResultsModal() {
			super();
			
			styleName = "micSettingsWindowStyle";
			width = 400;
			height = 300;
			setStyle("verticalGap", 15);
			// showCloseButton = false;
			layout = "vertical";
			setStyle("horizontalAlign", "center");
			setStyle("verticalAlign", "middle");
			
			var modalTitle:TextArea = new TextArea();
			modalTitle.setStyle("borderSkin", null);
			// modalTitle.verticalScrollPolicy = ScrollPolicy.OFF;
			modalTitle.editable = false;
			modalTitle.text = ResourceManager.getInstance().getString('resources', 'polling.pollModal.title');
			modalTitle.styleName = "micSettingsWindowTitleStyle";
			modalTitle.percentWidth = 100;
			modalTitle.height = 25;
			addElement(modalTitle);
			
			var hrule:Line = new Line();
			hrule.percentWidth = 100;
			addElement(hrule);
			
			_pollGraphic = new PollGraphic();
			_pollGraphic.data = null;
			_pollGraphic.width = 300;
			_pollGraphic.minWidth = 130;
			addElement(_pollGraphic);
			
			var respondersBox:HGroup = new HGroup();
			respondersBox.setStyle("horizontalGap", 0);
			
			_respondersLabel = new Label();
			_respondersLabel.setStyle("textAlign", "right");
			_respondersLabel.styleName = "pollResondersLabelStyle";
			_respondersLabel.text = ResourceManager.getInstance().getString('resources', 'polling.respondersLabel.novotes');
			respondersBox.addElement(_respondersLabel);
			
			_respondersLabelDots = new Label();
			_respondersLabelDots.width = 20;
			_respondersLabelDots.setStyle("textAlign", "left");
			_respondersLabelDots.styleName="pollResondersLabelStyle";
			_respondersLabelDots.text = "";
			respondersBox.addElement(_respondersLabelDots);
			
			addElement(respondersBox);
			
			hrule = new Line();
			hrule.percentWidth = 100;
			addElement(hrule);
			
			var botBox:HGroup = new HGroup();
			botBox.percentWidth = 90;
			botBox.setStyle("gap", 10);
			botBox.setStyle("horizontalAlign", "right");
			
			_publishBtn = new Button();
			_publishBtn.label = ResourceManager.getInstance().getString('resources', 'polling.publishButton.label');
			_publishBtn.addEventListener(MouseEvent.CLICK, handlePublishClick);
			botBox.addElement(_publishBtn);
			_closeBtn = new Button();
			_closeBtn.label = ResourceManager.getInstance().getString('resources', 'polling.closeButton.label');
			_closeBtn.addEventListener(MouseEvent.CLICK, handleCloseClick);
			botBox.addElement(_closeBtn);
			addElement(botBox);
			
			_voteListener = new Listener();
			_voteListener.type = PollVotedEvent.POLL_VOTED;
//			_voteListener.method = handlePollVotedEvent;
			
			_stopPollListener = new Listener();
			_stopPollListener.type = PollStoppedEvent.POLL_STOPPED;
			_stopPollListener.method = handlePollStoppedEvent;
			
			_dotTimer = new Timer(200, 0);
			_dotTimer.addEventListener(TimerEvent.TIMER, dotAnimate);
			_dotTimer.start();
		}
		
		public function setPoll(poll:SimplePoll):void {
			var resultData:Array = new Array();
			var answers:Array = poll.answers; 
			for (var j:int = 0; j < answers.length; j++) {
				var a:SimpleAnswer = answers[j] as SimpleAnswer;
				var localizedKey: String = ResourceManager.getInstance().getString('resources', 'polling.answer.' + a.key);
				
				if (localizedKey == null || localizedKey == "" || localizedKey == "undefined") {
					localizedKey = a.key
				} 
				resultData.push({a:localizedKey, v:0});
			}
			
			_pollGraphic.data = resultData;
			_pollGraphic.height = ((23+10)*_pollGraphic.data.length+10);
			_pollGraphic.minHeight = ((16+10)*_pollGraphic.data.length+10);
			
			height = _pollGraphic.height + 220;
		}
		
//		private function handlePollVotedEvent(e:PollVotedEvent):void {
//			if (_dotTimer && _dotTimer.running) {
//				_dotTimer.stop();
//				_dotTimer = null;
//			}
//			_respondersLabelDots.visible = false;
//			_respondersLabelDots.includeInLayout = false;
//			
//			var resultData:Array = new Array();
//			var answers:Array = e.result.answers; 
//			for (var j:int = 0; j < answers.length; j++) {
//				var a:SimpleAnswerResult = answers[j] as SimpleAnswerResult;
//				var localizedKey: String = ResourceManager.getInstance().getString('resources', 'polling.answer.' + a.key);
//				
//				if (localizedKey == null || localizedKey == "" || localizedKey == "undefined") {
//					localizedKey = a.key;
//				} 
//				
//				resultData.push({a:localizedKey, v:a.numVotes});
//			}
//			
//			_pollGraphic.data = resultData;
//			if (e.result.numResponders != e.result.numRespondents) {
//				_respondersLabel.text = e.result.numResponders + "/" + e.result.numRespondents;
//			} else {
//				_respondersLabel.text = ResourceManager.getInstance().getString('resources', 'polling.respondersLabel.finished');
//			}
//		}
		
		private function handlePollStoppedEvent(e:PollStoppedEvent):void {
			close();
		}
		
		private function handlePublishClick(e:MouseEvent):void {
			var dispatcher:Dispatcher = new Dispatcher();
			dispatcher.dispatchEvent(new ShowPollResultEvent(true));
			close();
		}
		
		private function handleCloseClick(e:MouseEvent):void {
			var dispatcher:Dispatcher = new Dispatcher();
			dispatcher.dispatchEvent(new StopPollEvent());
			close();
		}
		
		private function close():void {
			_voteListener.type = null;
			_voteListener.method = null;
			_voteListener = null;
			
			_stopPollListener.type = null;
			_stopPollListener.method = null;
			_stopPollListener = null;
			
			PopUpManager.removePopUp(this);
		}
		
		private function dotAnimate(e:TimerEvent):void {
			if (_respondersLabelDots.text.length > 5) {
				_respondersLabelDots.text = "";
			} else {
				_respondersLabelDots.text += ".";
			}
		}
	}
}