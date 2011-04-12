package net.poweru.placemanager
{
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	/* 	This is a sample component factory, but is not required.  As expected, feel free to
		roll your own, as long as it implements the interface.  Note that if you do use
		this as your superclass, you must re-define the getInstance() method.  Copy-and-paste
		of the one below will work fine. */
	public class ComponentFactory extends Object implements IComponentFactory
	{
		protected static var instance:ComponentFactory;
		protected var facade:IFacade;
		protected var componentDict:Object;
	
		public function ComponentFactory()
		{
			super();
			facade = Facade.getInstance();
			componentDict = new Object();
		}
		
		/*	You must override this in a sub-class.  Hint: use a switch statement, and for each
			place name you care about, use the getOrCreate() method. */
		public function getComponent(name:String):DisplayObject
		{
			return new PlaceNotFound();
		}
		
		// Removes any reference to the named component from this instance
		public function unloadComponent(name:String):void
		{
			if (componentDict.hasOwnProperty(name))
				componentDict[name] = null;
		}
		
		public static function getInstance():IComponentFactory
		{
			if (instance == null)
				instance = new ComponentFactory();
			return instance;
		}
		
		/* 	Get a component of the given name.  If we already have one in the componentDict, return it.
			If not, create one, then check for a mediator.  If one exists, make it aware of the new view
			component.  If one does not exist, create one and register it. */
		protected function getOrCreate(name:String, componentType:Class, mediatorType:Class=null):DisplayObject
		{
			if (!componentDict.hasOwnProperty(name) || componentDict[name] == null)
			{
				var component:DisplayObject = new componentType()
				componentDict[name] = component;
				if (mediatorType)
				{
					if (facade.hasMediator(mediatorType.NAME))
						facade.retrieveMediator(mediatorType.NAME).setViewComponent(component);
					else
						facade.registerMediator(new mediatorType(component));
				}
			}
			return componentDict[name];
		}
	}
}