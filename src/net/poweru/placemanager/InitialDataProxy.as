package net.poweru.placemanager
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/*	Use this class to store initial data necessary for any component. For example,
		when an Edit User dialog is requested, its mediator needs to know which user
		to edit.  You would call setInitialData(EDITUSERDIALOG, 4) perhaps to signify
		that the user with primary key 4 should be edited.  Once the dialog is created,
		its mediator will call this proxy to get the appropriate data.
		
		This also provides a sensible historical record.  If a dialog is requested without
		initial data specified, it will default to the last initial data that was used.
		As such, you should make sure that your app clears this proxy when a user session ends. */
		
	public class InitialDataProxy extends Proxy implements IProxy
	{
		public static const NAME:String = 'InitialDataProxy';
		
		public function InitialDataProxy()
		{
			super(NAME, new Object());
		}
		
		public function setInitialData(name:String, initialData:Object):void
		{
			data[name] = initialData;
		}
		
		public function getInitialData(name:String):Object
		{
			var ret:Object;
			if (data.hasOwnProperty(name))
				ret = data[name];
			return ret;
		}
		
		public function clear():void
		{
			data = {};
		}
		
	}
}