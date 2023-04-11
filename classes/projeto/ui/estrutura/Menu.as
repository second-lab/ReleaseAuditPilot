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

package projeto.ui.estrutura 
{
	import bulldog.core.Navigation;
	import bulldog.vo.VoInfoArea;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import projeto.SiteFacade;
	import utils.Proxy;
	
	
	
	
	public class Menu 
	{
		private var McMenu:MovieClip;
		
		public function Menu(container:MovieClip)
		{
			McMenu = container;
			
			for (var i:uint = 0 ; i < container.numChildren;i++ )
			{
				var menuItem:MovieClip = MovieClip(container.getChildAt(i));
				menuItem.buttonMode = true;
				menuItem.addEventListener(MouseEvent.CLICK , Proxy.create(this , GoTo , SiteFacade.Instance.OView.GetInfoArea(menuItem.name)));
			}
		}
		
		private function GoTo(e:Event , VO:VoInfoArea):void
		{
			Navigation.GoTo(VO);
		}
	}
}