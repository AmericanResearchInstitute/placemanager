package net.poweru.placemanager
{
	import flash.display.DisplayObject;
	
	import mx.containers.HBox;
	import mx.events.FlexEvent;
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;

	/* 	You can use this as a container for loading a module.  It is handy because the
		IComponentFactory implementation can return this right away while the module
		gets loaded asynchronously. */
	public class ModuleContainer extends HBox
	{
		protected var info:IModuleInfo;
		
		public function ModuleContainer(url:String)
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			percentHeight = 100;
			percentWidth = 100;
			info = ModuleManager.getModule(url);
			info.addEventListener(ModuleEvent.READY, onModuleReady);
		}
		
		protected function onCreationComplete(event:FlexEvent):void
		{
			info.load();
		}
		
		protected function onModuleReady(event:ModuleEvent):void
		{
			addChild(info.factory.create() as DisplayObject);
		}
		
	}
}