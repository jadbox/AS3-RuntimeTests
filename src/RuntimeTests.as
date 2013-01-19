package
{
	import com.gskinner.performance.PerformanceTest;
	import com.gskinner.performance.TestSuite;
	import com.gskinner.performance.TextLog;
	import com.gskinner.performance.XMLLog;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import as3tests.Assert;
	import as3tests.TestCase;
	
	// Universal TestRunner
	public class RuntimeTests extends Sprite
	{
		public var outFld:TextField;
		public var loopsMultiple:Number=1;
		
		public function RuntimeTests()
		{
			super();
			trace("Test started");
			outFld = new TextField();
			outFld.width = stage.stageWidth;
			outFld.height = stage.stageHeight;
			outFld.scrollRect = new Rectangle(0,0,outFld.width,outFld.height);
			addChild(outFld);
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			PerformanceTest.getInstance().delay = 500;
			outFld.text = "Running tests on "+Capabilities.version+" "+(Capabilities.isDebugger ? "DEBUG" : "RELEASE")+" with loopsMultiple="+loopsMultiple+"...\n";
			new TextLog().out = out;
			new XMLLog().out = out2;
			
			//Assert.onError = onError;
			//Assert.onSuccess = out;
			
			queueTest(new TestCase());
		}
		private function onError(msg:String, warn:Boolean):void {
			out(msg);
		}
		private function queueTest(test:*):void {
			if ("loops" in test) {
				test.loops = test.loops*loopsMultiple|0;
			} else {
				out("* Test: "+test.name+" does not have a loops property.");
			}
			PerformanceTest.queue(test);
		}
		private function out(str:*):void {
			outFld.appendText(String(str)+"\n");
			outFld.scrollV = outFld.maxScrollV;
			trace(str);
		}
		private function out2(str:*):void {
			outFld.appendText("\n"+String(str)+"\n");
			outFld.scrollV = outFld.maxScrollV;
		}
		private function handleTestComplete(evt:Event):void {
			var test:TestSuite = evt.target as TestSuite;
			trace(test.toXML().toXMLString());
		}
	}
}