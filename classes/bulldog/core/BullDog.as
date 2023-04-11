/**
 * BullDOG 2.1.0 - Flash Extension Framework <http://www.luizsegundo.com.br/bulldog>
 *
 * BullDOG is (c) 2008-2010 Luiz Segundo
 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 *
 * 
 * Written by: Luiz Segundo <http://www.luizsegundo.com.br>
 *
 **/

package bulldog.core 
{
	
	import bulldog.debug.BullDogException;
	import bulldog.events.ModelEvent;
	import bulldog.events.ViewEvent;
	import flash.display.Sprite;
	import projeto.SiteFacade;
	
	

	public class BullDog extends Sprite
	{
		/** 
		 * Variável Static instance:BullDog. 
		 * 
		 * @default this(SINGLETON) 
		 */
		protected static var instance:BullDog; 
		
		/**
		 * Construtor BullDog.
		 * 
		 * Inicia a instância para ser SINGLETON.
		 */
		public function BullDog() 
		{
			if (instance != null) throw BullDogException(BullDogException.SINGLETON);
			instance = this;
			initializeFacade();	
		}
		
		/**
		 * Método Protected Static Get Instance.
		 * 
		 * @return Instância de BullDog.
		 */
		protected static function get Instance():BullDog 
		{
			if (instance == null) instance = new BullDog();
			return instance;
		}
		
		/**
		 * Método Private initializeFacade.
		 */
		private function initializeFacade( ):void 
		{
			InitializeModel();
		}
		
		/**
		 * Método Private InitializeModel.
		 */
		private function InitializeModel():void
		{
			SiteFacade.Instance.OModel.URLInfo   = this.loaderInfo.url;		
			SiteFacade.Instance.OModel.OStage    = stage;
			SiteFacade.Instance.OModel.InitializeModelProvider();			
			SiteFacade.Instance.OModel.FlashVars = this.loaderInfo.parameters;
			SiteFacade.Instance.OModel.addEventListener(ModelEvent.INITIALIZED , InitializeView);
		}
		
		/**
		 * Método Private InitializeView.
		 * 
		 * @param e:ModelEvent Evento
		 */
		private function InitializeView(e:ModelEvent):void
		{	
			SiteFacade.Instance.OView.addEventListener(ViewEvent.INITIALIZED , InitializeController);
		}
		
		/**
		 * Método Private InitializeController.
		 * 
		 * @param e:ViewEvent Evento
		 */
		private function InitializeController(e:ViewEvent):void
		{
			SiteFacade.Instance.OController.InitializeController();
		}
	}
}