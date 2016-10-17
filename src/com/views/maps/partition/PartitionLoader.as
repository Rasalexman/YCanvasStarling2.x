package com.views.maps.partition
{
    import flash.display.Loader;
    
    import com.views.maps.net.LoaderOptimizer;
    import sk.yoz.ycanvas.map.partitions.IPartitionLoader;
    
    public class PartitionLoader extends LoaderOptimizer 
        implements IPartitionLoader
    {
        public function disposeLoader(loader:Loader):void
        {
            release(loader);
        }
    }
}