package as3tests
{
	import com.gskinner.performance.AbstractTest;
	import com.gskinner.performance.MethodTest;
	import com.gskinner.performance.TestSuite;
	
	import flash.geom.Point;
	
	public class TestCase extends TestSuite
	{
		public var loops:uint = 100000;
		public function TestCase()
		{
			name = "TestCase";
			description = "This is a test case example.";
			tareTest = new MethodTest(tare);
			initFunction = init;
			iterations = 1;
			tests = [
				new MethodTest(testFunc, null, "TestCaseExample1", 0, 1),
			];
		}
		
		protected function testFunc():void {
			for (var i:uint=0; i<loops; i++) {
				var x:uint = i * 2;
			}
			Assert.isTrue(true==false, "test eval");
		}
		
		protected function init():void {
			//points = [];
			for (var i:uint=0; i<loops; i++) {
				//points[i] = new Point(i,i/3);
			}
		}
		
		// tare method that will be run to calculate the base time required to run the loop
		// so it can be subtracted from the other test results.
		protected function tare():void {
			for (var i:uint=0; i<loops; i++) {
				
			}
		}
	}
}