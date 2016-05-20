package org.bigbluebutton.core {
	
	import org.bigbluebutton.model.User;
	import org.osflash.signals.ISignal;
	
	public interface IUsersService {
		function setupMessageSenderReceiver():void;
		function sendJoinMeetingMessage():void;
		function kickUser(userID:String):void;
		function queryForParticipants():void;
		function assignPresenter(userid:String, name:String, assignedBy:String):void;
		function changeMood(mood:String):void
		function clearUserStatus(userID:String):void
		function addStream(userID:String, streamName:String):void;
		function getGuestPolicy():void
		function responseToGuest(userID:String, response:Boolean):void
		function responseToAllGuests(response:Boolean):void
		function removeStream(userID:String, streamName:String):void;
		function queryForRecordingStatus():void;
		function changeRecordingStatus(userID:String, recording:Boolean):void;
		function muteAllUsers(mute:Boolean):void;
		function muteAllUsersExceptPresenter(mute:Boolean):void;
		function muteUnmuteUser(userid:String, mute:Boolean):void;
		function ejectUser(userid:String):void;
		function getRoomMuteState():void;
		function getRoomLockState():void;
		function setAllUsersLock(lock:Boolean, except:Array = null):void;
		function setUserLock(internalUserID:String, lock:Boolean):void;
		function getLockSettings():void;
		function saveLockSettings(newLockSettings:Object):void;
		function muteMe():void;
		function unmuteMe():void;
		function mute(user:User):void;
		function unmute(user:User):void;
		function validateToken():void;
		function changeRole(userID:String, role:String):void;
		function lowerHand(userID:String, loweredBy:String):void;
	}
}
