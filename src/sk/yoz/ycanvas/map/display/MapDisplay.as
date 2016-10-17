package sk.yoz.ycanvas.map.display
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import starling.display.DisplayObject;
    import starling.display.Quad;
    import starling.display.Sprite;
    
    import utils.Dimansion;
    
    /**
    * Starling implementation for map component.
    */
    public class MapDisplay extends Sprite
    {
        /**
        * Viewport updated event constant.
        */
        public static const VIEWPORT_UPDATED:String = "viewPortUpdated"; 
        private var _starlingViewPort:Rectangle;
        private var _clipRect:Quad = new Quad(200,200);
        
        /**
        * Width of the component is handled custom for clipping purposes.
        */
        override public function get width():Number
        {
            return Dimansion.screenWidth;
        }
        
        /**
         * Width of the component is handled custom for clipping purposes.
         */
        override public function get height():Number
        {
            return Dimansion.screenHeight;
        }
        
        /**
        * @inheritDoc
        */
        override public function set x(value:Number):void
        {
            super.x = value;
            invalidateStarlingViewPort();
        }
        
        /**
        * @inheritDoc
        */
        override public function set y(value:Number):void
        {
            super.y = value;
            invalidateStarlingViewPort();
        }
        
        /**
        * Returns viewport in starling viewport coordinates.
        */
        private function get starlingViewPort():Rectangle
        {
            if(!_starlingViewPort)
            {
                var point:Point = localToGlobal(new Point(0, 0));
                _starlingViewPort = new Rectangle(point.x, point.y, width, height);
            }
            
            return _starlingViewPort;
        }
        
        /**
        * @inheritDoc
        */
        override public function hitTest(localPoint:Point):DisplayObject
        {
            if((!visible || !touchable))
                return null;
            
            var localX:Number = localPoint.x;
            var localY:Number = localPoint.y;
            var object:DisplayObject = super.hitTest(localPoint);
            if(object)
                return object;
            
            var globalPoint:Point = localToGlobal(new Point(localX, localY));
            return starlingViewPort.contains(globalPoint.x, globalPoint.y)
                ? this : null;
        }
        
        /**
        * Clip rectangle is updated whenever width/height is changed.
        */
        private function validateClipRect():void
        {
            _clipRect.width = width;
            _clipRect.height = height;
            mask = _clipRect;
        }
        
        /**
        * Invalidation is required in case of viewport of component is changed
        * in starling coordinates.
        */
        public function invalidateStarlingViewPort():void
        {
            _starlingViewPort = null;
            dispatchEventWith(VIEWPORT_UPDATED);
        }
    }
}