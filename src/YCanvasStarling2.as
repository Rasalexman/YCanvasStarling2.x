package
{
	import com.views.application.CMapApplication;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	import utils.Dimansion;
	
	public class YCanvasStarling2 extends Sprite
	{
		
		private var _mStarling					:	Starling;
		
		public function YCanvasStarling2()
		{
			super();
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddeToStageHandler, false, 0, true);
			init__display();
		}
		
		// Инициализируем экран приложения
		private function init__display():void {	
			
			// support autoOrients			
			if(this.stage) {
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.quality = StageQuality.HIGH;
				this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				this.mouseEnabled = this.mouseChildren = false;
			}
			
			// The player SWF file on www.youtube.com needs to communicate with your host
			// SWF file. Your code must call Security.allowDomain() to allow this
			// communication.
			//Security.allowDomain("www.youtube.com");
			Starling.multitouchEnabled = true;
			// init dimansions
			Dimansion.init(this.stage);
		}
		
		protected function onAddeToStageHandler(event:flash.events.Event):void
		{			
			
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddeToStageHandler);				
			// init Starling
			var viewPort:Rectangle = new Rectangle(0, 0, Dimansion.screenWidth, Dimansion.screenHeight);			
			this._mStarling = new Starling(CMapApplication, this.stage, viewPort); // , null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE_CONSTRAINED
			this._mStarling.supportHighResolutions = true;
			this._mStarling.skipUnchangedFrames = true;
			this._mStarling.enableErrorChecking = false;
			Starling.current.showStats = true;
			// this event is dispatched when stage3D is set up
			this._mStarling.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onRootCreated);
		}
		
		private function onRootCreated():void {
			// start Starling
			this._mStarling.removeEventListeners(starling.events.Event.CONTEXT3D_CREATE);
			this._mStarling.nativeStage.frameRate = 60;
			this._mStarling.start();
			this.stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		private function stage_deactivateHandler(event:flash.events.Event):void	{
			this._mStarling.stop();
			this.stage.addEventListener(flash.events.Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		private function stage_activateHandler(event:flash.events.Event):void {
			this.stage.removeEventListener(flash.events.Event.ACTIVATE, stage_activateHandler);
			this._mStarling.start();
		}
	}
}