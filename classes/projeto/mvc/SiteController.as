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

package projeto.mvc 
{
	import bulldog.core.Controller;
	import bulldog.core.Navigation;
	import bulldog.events.ControllerEvent;
	import projeto.SiteFacade;
	

	public class SiteController extends Controller
	{
		/**
		 * Construtor SiteController.
		 */
		public function SiteController()
		{	
			super();
			addEventListener(ControllerEvent.INITIALIZED , InitializeSiteController);
		}
		
		/**
		 * Método Public InitializeSiteController.
		 * 
		 * @param e:ControllerEvent Evento
		 */
		public function InitializeSiteController(e:ControllerEvent):void 
		{
			NavegaSetup();
		}
		
		/**
		 * Método Private NavegaSetup.
		 */
		private function NavegaSetup():void
		{
			Navigation.Container               = SiteFacade.Instance.OView;
			Navigation.McLoading               = SiteFacade.Instance.OView.McLoading;
			Navigation.SwfAddress              = SiteFacade.Instance.OModel.GetValue("enabled" , "swfaddress");
			Navigation.SwfAddressSetTitle      = SiteFacade.Instance.OModel.GetValue("settitle" , "swfaddress");
			Navigation.GoogleAnalytics         = SiteFacade.Instance.OModel.GetValue("googleanalytics" , "navega");
			Navigation.HasContextMenu          = SiteFacade.Instance.OModel.GetValue("contextmenu" , "navega");
			Navigation.RemoveAboveOnNavigation = SiteFacade.Instance.OModel.GetValue("removeAboveOnNavigation" , "navega");
			Navigation.TitleContextMenu        = SiteFacade.Instance.OModel.GetValue("nomeprojeto" , "settings");
			Navigation.BrowserMainTitle        = SiteFacade.Instance.OModel.GetValue("nomeprojeto" , "settings");
			Navigation.PathAreasSwf            = SiteFacade.Instance.OModel.URLSwf;
			Navigation.AreaInicial             = SiteFacade.Instance.OView.GetInicialInfoArea();
			Navigation.Init();
		}
	}
}