package net.poweru.placemanager
{
	import flash.display.DisplayObject;
	
	public interface IComponentFactory
	{
		function getComponent(name:String):DisplayObject;
		function unloadComponent(name:String):void;
	}
}