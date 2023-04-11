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

package utils
{
	import flash.display.MovieClip;
	
	public class DisplayLoadProgress extends MovieClip
	{
		public var mcLoader:MovieClip;
			
		public function showDisplay():void
		{
			if (mcLoader.perc_txt != null)
			{
				mcLoader.perc_txt.text = "..";
			}
			
			if (mcLoader.barra_mc != null)
			{
				mcLoader.barra_mc.scaleX = 0;
			}
			
			if (mcLoader.barraVertical_mc != null)
			{
				mcLoader.barraVertical_mc.scaleY = 0;
			}
			
			mcLoader.visible = true;
		}
		
		public function showProgress(bLoaded:uint,bTotal:uint):void 
		{
			var perc:uint = uint((bLoaded / bTotal) * 100);
									
			if (mcLoader.perc_txt != null)
			{
				mcLoader.perc_txt.text = perc + " %";
			}
			
			if (mcLoader.barra_mc != null)
			{
				mcLoader.barra_mc.scaleX = perc / 100;				
			}
			
			if (mcLoader.barraVertical_mc != null)
			{
				mcLoader.barraVertical_mc.scaleY = perc / 100;
			}
		}

		public function hideDisplay():void 
		{
			mcLoader.visible = false;
		}
	}
	
}