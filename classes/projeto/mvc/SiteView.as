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

package projeto.mvc {
	import bulldog.api.IView;
	import bulldog.core.View;
	import bulldog.events.ViewEvent;
	import projeto.ui.estrutura.Menu;
	import projeto.ui.views.*;
	import utils.IndexManager;
	
	

	public class SiteView extends View implements IView
	{
		/**
		 * Construtor SiteView.
		 */
		public function SiteView()
		{	
			super();
			addEventListener(ViewEvent.INITIALIZED , InitializeSiteView);
		}

		/**
		 * Método Protected GetClassLibrary.
		 * 
		 * @param e:ViewEvent Variável
		 */
		public function InitializeSiteView(e:ViewEvent):void 
		{
			InitObjects();
		}

		/**
		 * Método Protected InitObjects.
		 */
		protected function InitObjects():void 
		{
			
			//INDEX ORGANIZE
			IndexManager.BringToFront(McMain.mcMenu , McMain);
			IndexManager.BringToFront(McLoading , McMain);
			
			//SAMPLE
			new Menu(McMain.mcMenu);
		}
	
		//INSTANCE VIEWS - SAMPLE
		private var oSWReleaseAudit:SWReleaseAudit;
		private var oPage2:Page2;
		
		public function get OSWReleaseAudit():SWReleaseAudit { return oSWReleaseAudit; }
		
		public function set OSWReleaseAudit(value:SWReleaseAudit):void 
		{
			oSWReleaseAudit = value;
		}
		
		public function get OPage2():Page2 { return oPage2; }
		
		public function set OPage2(value:Page2):void 
		{
			oPage2 = value;
		}
	}
}