package utils
{
	import flash.display.Stage;

	public class Dimansion
	{
		///////////// ASSETS NAMES		
		public static var 	proportion					:Number,
							screenWidth					:int,			// SCREEN DIMANSIONS
							screenHeight				:int;
							
		public static function init( display:Stage ) : void {
			screenWidth = display.fullScreenWidth;
			screenHeight = display.fullScreenHeight;
			
			// ONLY FOR SCALE MARKER IN RIGHT PRPORTIONS, CAUSE I MADE IT (marker image) FOR MY PHONE SCREEN RESOLUTION
			proportion = NumberUtilities.round(screenHeight / 1920, 0.1);
		}
	}
}