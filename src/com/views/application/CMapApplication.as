package com.views.application
{
	import com.views.maps.CMapHelperMain;
	import com.views.maps.partition.PartitionLoader;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.themes.MetalWorksMobileTheme;
	
	import utils.Dimansion;
	
	public class CMapApplication extends Screen
	{
		
		private var _mPartitionLoader:PartitionLoader,
				
					_mMapMain:CMapHelperMain; 
		
		public function CMapApplication()
		{
			super();
			this.width = Dimansion.screenWidth;
			this.clipContent = false;
			
			new MetalWorksMobileTheme();
		}
		
		override protected function initialize():void{
			super.initialize();
				
			// TILES LOADER (U CAN CHANGE TILES WIDTH AND HEIGHT IN com.constants.Maps)
			_mPartitionLoader = new PartitionLoader();
			// MAIN MAP HOLDER
			_mMapMain = new CMapHelperMain(_mPartitionLoader);
			this.addChild(_mMapMain.map.display);
			_mMapMain.map.display.invalidateStarlingViewPort();
			
			/// ADD ANY UI U WANT 
			addAnyUI();
		}
		
		private function addAnyUI():void {
			var updateButton:Button = new Button();
			updateButton.label = "UPDATE";
			updateButton.validate();
			
			updateButton.x = (Dimansion.screenWidth-updateButton.width)>>1;
			updateButton.y = updateButton.height;
			this.addChild(updateButton);
		}
	}
}