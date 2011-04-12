package net.poweru.placemanager
{
	import mx.core.Container;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class SpaceMediator extends Mediator implements IMediator
	{
		public static const CLEARSPACE:String = 'ClearSpace';
		public static const LOGOUT:String = 'Logout';
		public static const NAME:String = 'SpaceMediator';
		public static const REMOVEDIALOG:String = 'RemoveDialog';
		public static const SHOWDIALOG:String = 'ShowDialog';
		public static const DIALOGPRESENTED:String = 'DialogPresented';
		public static const SETSPACE:String = 'SetSpace';
		public static const SPACEREADY:String = 'SpaceReady';
		
		protected var componentFactory:IComponentFactory;
		protected var initialDataProxy:InitialDataProxy;
		
		public function SpaceMediator(viewComponent:Object, componentFactory:IComponentFactory)
		{
			super(NAME, viewComponent);
			this.componentFactory = componentFactory;
			initialDataProxy = facade.retrieveProxy(InitialDataProxy.NAME) as InitialDataProxy;
			if (initialDataProxy == null)
			{
				initialDataProxy = new InitialDataProxy();
				facade.registerProxy(initialDataProxy);
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [CLEARSPACE, REMOVEDIALOG, SETSPACE, SHOWDIALOG];
		}
		
		override public function onRegister():void
		{
			sendNotification(SPACEREADY);
		}
		
		protected function get space():Container
		{
			return viewComponent as Container;
		}
		
		protected function clearSpace():void
		{
			space.removeAllChildren();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case REMOVEDIALOG:
					PopUpManager.removePopUp(notification.getBody() as IFlexDisplayObject);
					break;
				
				case SETSPACE:
					clearSpace();
					space.addChild(componentFactory.getComponent(notification.getBody() as String));
					break;
					
				case CLEARSPACE:
					clearSpace();
					break;
					
				case SHOWDIALOG:
					// first item should be a place name, second argument whatever data the dialog needs
					var dialogInfo:Array = notification.getBody() as Array;
					initialDataProxy.setInitialData(dialogInfo[0], dialogInfo[1]);
					var dialog:IFlexDisplayObject = componentFactory.getComponent(dialogInfo[0]) as IFlexDisplayObject;
					PopUpManager.addPopUp(dialog, space, true);
					PopUpManager.centerPopUp(dialog);
					sendNotification(DIALOGPRESENTED, dialogInfo[0]);
					break;
			}
		}
		
	}
}