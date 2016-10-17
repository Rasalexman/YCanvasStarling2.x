package com.constants
{
    import sk.yoz.ycanvas.map.valueObjects.MapConfig;

    /**
    * This class provides implementation of some tile providers
    * (mapquest, openstreetmaps, cloudmade, arcgis)
    */
    public class Maps
    {
        private static var _OSM:MapConfig;
        private static var _ARCGIS_IMAGERY:MapConfig;
        private static var _ARCGIS_NATIONAL_GEOGRAPHIC:MapConfig;
        private static var _ARCGIS_REFERENCE:MapConfig;
        private static var _BINGMAPS_IMAGERY:MapConfig;
        
		/// GOOD IN BOTH QUALITY SETTINGS 256 / 512
        public static function get OSM():MapConfig
        {
            if(!_OSM)
                _OSM = createMapConfig([
                    "http://a.tile.openstreetmap.org/${z}/${x}/${y}.png",
                    "http://b.tile.openstreetmap.org/${z}/${x}/${y}.png",
                    "http://c.tile.openstreetmap.org/${z}/${x}/${y}.png"]);
            return _OSM;
        }
        
        public static function get ARCGIS_IMAGERY():MapConfig
        {
            if(!_ARCGIS_IMAGERY)
                _ARCGIS_IMAGERY = createMapConfig([
                    "http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/${z}/${y}/${x}.png",
                    "http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/${z}/${y}/${x}.png"]);
            return _ARCGIS_IMAGERY;
        }
        
		/// WORKS ONLY ON BIG SCALE MAPS LIKE CITIES AND COUNTRIES MAP
        public static function get ARCGIS_NATIONAL_GEOGRAPHIC():MapConfig
        {
            if(!_ARCGIS_NATIONAL_GEOGRAPHIC)
                _ARCGIS_NATIONAL_GEOGRAPHIC = createMapConfig([
                    "http://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/${z}/${y}/${x}.png",
                    "http://services.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/${z}/${y}/${x}.png"]);
            return _ARCGIS_NATIONAL_GEOGRAPHIC;
        }
        
		/// ONLY REFERENCE ON MAP GOOD FOR LAYER
        public static function get ARCGIS_REFERENCE():MapConfig
        {
            if(!_ARCGIS_REFERENCE)
                _ARCGIS_REFERENCE = createMapConfig([
                    "http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/${z}/${y}/${x}.png",
                    "http://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/${z}/${y}/${x}.png"]);
            return _ARCGIS_REFERENCE;
        }
        
		/// GOOD, BUT NOT HAVE A LOT OF QUALITY
        public static function get BINGMAPS_IMAGERY():MapConfig
        {
            if(!_BINGMAPS_IMAGERY)
                _BINGMAPS_IMAGERY = createMapConfig([
                    "http://ecn.t0.tiles.virtualearth.net/tiles/a${bingMapsQuadKey}.jpeg?g=1494",
                    "http://ecn.t1.tiles.virtualearth.net/tiles/a${bingMapsQuadKey}.jpeg?g=1494",
                    "http://ecn.t2.tiles.virtualearth.net/tiles/a${bingMapsQuadKey}.jpeg?g=1494",
                    "http://ecn.t3.tiles.virtualearth.net/tiles/a${bingMapsQuadKey}.jpeg?g=1494"]);
            return _BINGMAPS_IMAGERY;
        }
        
        private static function createMapConfig(templates:Array):MapConfig
        {
            var result:MapConfig = new MapConfig;
            result.urlTemplates = Vector.<String>(templates);
            result.tileWidth = 256; 	// or 512 on big resolution but u can use sk.yoz.image.ImageResizer when download ur tiles
            result.tileHeight = 256;	// or 512 on big resolution 
            return result;
        }
    }
}