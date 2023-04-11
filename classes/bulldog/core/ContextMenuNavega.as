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
	import bulldog.vo.VoInfoArea;
	import flash.display.MovieClip;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import projeto.SiteFacade;
	import utils.Proxy;
	
	
	

	public class ContextMenuNavega extends MovieClip
	{
		/** 
		 * Variável meuContextMenu:ContextMenu. 
		 * 
		 * @default new ContextMenu()
		 */
		private var meuContextMenu:ContextMenu;
		
		/** 
		 * Variável builtInItems:Boolean. 
		 * 
		 * @default false 
		 */
		private var builtInItems:Boolean = false;
		
		/**
		 * @private
		 */
		public function set BuiltInItems(value:Boolean):void 
		{
			builtInItems = value;
		}
		
		/**
		 * @private
		 */
		public function set ProjectTitle(value:String):void 
		{
			if (value != null)
			{
				AddItem(null , value);
			}
		}
		
		/**
		 * Construtor ContextMenuNavega.
		 */
		public function ContextMenuNavega()
		{
			meuContextMenu = new ContextMenu();
			
			if (!builtInItems)
			{
				meuContextMenu.hideBuiltInItems();
			}
		}
		
		/**
		 * Método Public AddItem.
		 * 
		 * @param area:VoInfoArea Variável
		 * @param strLabel:String
		 */
		public function AddItem(area:VoInfoArea , strLabel:String = null):void
		{
			var meuItem:ContextMenuItem;
			
			if (area != null)
			{
				meuItem = new ContextMenuItem(SiteFacade.Instance.OModel.GetValue("contextMenuSeparator" , "navega") + area.Descricao);
				meuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Proxy.create(this , NavegaMenu , area));
			}
			else
			{
				meuItem = new ContextMenuItem(SiteFacade.Instance.OModel.GetValue("contextMenuPrefix" , "navega") + strLabel);
				meuItem.separatorBefore = true;
			}
			
			meuContextMenu.customItems.push(meuItem);
			SiteFacade.Instance.OView.McMain.contextMenu = meuContextMenu;
		}
		
		/**
		 * Método Private AddItem.
		 * 
		 * @param e:ContextMenuEvent Evento
		 * @param pArea:VoInfoArea Variável
		 */
		private function NavegaMenu(e:ContextMenuEvent , pArea:VoInfoArea):void 
		{
			Navigation.GoTo(pArea);
		}
	}
}