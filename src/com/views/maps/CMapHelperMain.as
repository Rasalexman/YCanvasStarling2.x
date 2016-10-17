package com.views.maps
{
    import com.constants.Maps;
    import com.views.maps.partition.CustomPartitionFactory;
    import com.views.maps.partition.PartitionLoader;
    

    import flash.geom.Point;
    import flash.system.Capabilities;
    
    import feathers.controls.Alert;
    import feathers.data.ListCollection;
    
    import sk.yoz.utils.GeoUtils;
    import sk.yoz.ycanvas.map.YCanvasMap;
    import sk.yoz.ycanvas.map.display.MarkerLayer;
    import sk.yoz.ycanvas.map.events.CanvasEvent;
    import sk.yoz.ycanvas.map.layers.LayerFactory;
    import sk.yoz.ycanvas.map.managers.AbstractTransformationManager;
    import sk.yoz.ycanvas.map.managers.MouseTransformationManager;
    import sk.yoz.ycanvas.map.managers.TouchTransformationManager;
    import sk.yoz.ycanvas.map.valueObjects.Limit;
    import sk.yoz.ycanvas.map.valueObjects.MapConfig;
    import sk.yoz.ycanvas.map.valueObjects.Transformation;
    
    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    
    import utils.Dimansion;

    /**
    * Provides functionality for the main map.
    */
    public class CMapHelperMain
    {
		
		public static var 	_mSavedX:Number,
							_mSavedY:Number;
							
		
		[Embed(source="/../assets/marker.png")]
		protected static const MARKER_BITMAP:Class;
				
		private var _mSelectedMarker:Image;
					
		public var 	map:YCanvasMap,
        			markerLayer:MarkerLayer,
					transformationManager:AbstractTransformationManager;
        
        public function CMapHelperMain(partitionLoader:PartitionLoader)
        {
			const transformation:Transformation = new Transformation;
			transformation.centerX = _mSavedX ? _mSavedX : GeoUtils.lon2x(30.331079);
			transformation.centerY = _mSavedY ? _mSavedY : GeoUtils.lat2y(59.934812);
			transformation.rotation = 0;
			transformation.scale = 1 / 8;
			
			const limit:Limit = new Limit;
			limit.minScale = 1;
			limit.maxScale = 1 / 65536;
			limit.minCenterX = 0;
			limit.maxCenterX = GeoUtils.lon2x(180);
			limit.minCenterY = GeoUtils.lat2y(85);
			limit.maxCenterY = GeoUtils.lat2y(-85);
			
			var config:MapConfig = Maps.OSM;		// The best quality
			
			// Main map engine based on YCANVAS Maps
			map = new YCanvasMap(config, transformation); 
			map.addEventListener(CanvasEvent.TRANSFORMATION_FINISHED, onMapTransformationFinished);
			// Lets customize partition factory so it creates CustomPartition
			// capable of handling bing maps
			map.partitionFactory = new CustomPartitionFactory(config, map, partitionLoader);
			map.layerFactory = new LayerFactory(config, map.partitionFactory);
			
			//trace("Capabilities.manufacturer",Capabilities.manufacturer);
			transformationManager = flash.system.Capabilities.manufacturer.indexOf("Android") == -1 ? new MouseTransformationManager(map, limit) : new TouchTransformationManager(map, limit);
			
			markerLayer = new MarkerLayer();
			markerLayer.addEventListener(TouchEvent.TOUCH, onMarkerLayerTouch);
			map.addMapLayer(markerLayer);			
			
			addMarkerAt(new Point(transformation.centerX, transformation.centerY));
						
			// TOUCH ON MAP AND PLACE MARKER
			//Starling.current.stage.addEventListener(TouchEvent.TOUCH, onStateTriggered);
        }
		
		private function onStateTriggered(e:TouchEvent):void {
			const touch:Touch = e.getTouch(Starling.current.stage, TouchPhase.ENDED);
			if(touch){
				var locationP:Point = map.globalToCanvas(touch.getLocation(Starling.current.stage));
				addMarkerAt(locationP);
				trace("onStateTriggered ", locationP);			
			}
		}
		
        public function addMarkerAt(pt:Point):void
        {
			var marker:Image = new Image(Texture.fromEmbeddedAsset(MARKER_BITMAP, false, false, 1+Dimansion.proportion));
			marker.touchable = true;
			marker.alignPivot("center","bottom");
			marker.x = pt.x;
			marker.y = pt.y;
			markerLayer.add(marker);
        }
        
        public function dispose():void
        {
			//map.removeEventListener(CanvasEvent.TRANSFORMATION_FINISHED, onMapTransformationFinished);
			map.removeMapLayer(markerLayer);
						
			markerLayer.removeChildren(0,-1,true);
			markerLayer.removeEventListener(TouchEvent.TOUCH, onMarkerLayerTouch);
			markerLayer.dispose();
			markerLayer = null;
			
            map.dispose();
            map = null;
            
            transformationManager.dispose();
            transformationManager = null;			
        }
        
        private function onMapTransformationFinished(event:CanvasEvent):void
        {
			/*
			if(_mMarkerInfo && _mSelectedMarker){
				_mMarkerInfo.x = _mSelectedMarker.x;
				_mMarkerInfo.y = _mSelectedMarker.y - _mSelectedMarker.height;
			}*/
        }
        
        private function onMarkerLayerTouch(event:TouchEvent):void
        {
			const touch:Touch = event.getTouch(map.display, TouchPhase.ENDED);
            if(touch) {
				
				if(event.target is Image){
					_mSelectedMarker = event.target as Image;
					showMarkerInfo();
				}
			}
		}
		
		private function showMarkerInfo():void{	
			Alert.show(
				"MARKER HAS TRIGGERED",
				"WARNING",
				new ListCollection([{ label: "OK" }])
			);
		}
    }
}