package as3tests
{
	public class Assert
	{
		public static var onError:Function = function(msg:String, warn:Boolean):void {
			var err:Error = new Error(msg);
			err.name = warn?"WARNING":"ERROR";
			throw err;
		}
		public static var onSuccess:Function;
		public static var warningMode:Boolean = false;
		
		/*private var onError:Function;
		private var onSuccess:Function;
		
		public function Assert(onSuccess:Function=null, onError:Function=null):void {
			this.onError = onError || onGlobalError;
			this.onSuccess = onSuccess || onGlobalSuccess;
		}
		
		
		public static function warn(assertOP:*):void {
			warningMode = true;
			
		}
		*/
		public static function isTrue(val:Boolean, testName:String):void {
			return exists(val, testName);
		}
		
		public static function isEq(val:*, toVal:*, testName:String):void {
			return isTrue(val==toVal, testName);
		}
		
		public static function isType(val:*, type:Class, testName:String):void {
			return isTrue(val is type, testName);
		}
		
		public static function exists(val:*, testName:String):void {
			if(!val) fail(testName);
			else success(testName);
		}
		
		public static function inRange(val:*, low:*, high:*, testName:String):void {
			if(val < low) fail(testName);
			else if(val > high) fail(testName);
			else success(testName);
		}
		
		private static function success(testName:String):void {
			if(onSuccess!==null) onSuccess("success: " + testName);
		}
		private static function fail(testName:String):void {
			if(onError!==null) onError("fail: " + testName, warningMode);
		}
	}
}