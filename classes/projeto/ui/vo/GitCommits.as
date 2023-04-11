package projeto.ui.vo 
{
	
	
	/**
	 * ...
	 * @author Luiz Segundo
	 */
	public class GitCommits extends Object
	{
		
		private var id:String;
		private var displayId:String;
		private var author:String;
		private var timeStamp:String;
		private var jiraKey:String;
		private var message:String;
		private var arrParents:Array;
		

	
		public function get Id ():String { return id; }
		
		public function set Id(value:String):void 
		{
			id = value;
		}
		
		
		public function get DisplayId ():String { return displayId; }
		
		public function set DisplayId(value:String):void 
		{
			displayId = value;
		}
		
	
	
		public function get Author ():String { return author; }
		
		public function set Author(value:String):void 
		{
			author = value;
		}
		
		
		public function get Message ():String { return message; }
		
		public function set Message(value:String):void 
		{
			message = value;
		}
		
		
		public function get TimeStamp ():String { return TimeStamp; }
		
		public function set TimeStamp(value:String):void 
		{
			timeStamp = value;
		}
		
		public function get JiraKey ():String { return jiraKey; }
		
		public function set JiraKey(value:String):void 
		{
			jiraKey = value;
		}
		
		public function get ArrParents ():Array { return arrParents; }
		
		public function set ArrParents(value:Array):void 
		{
			arrParents = value;
		}
	
		
		public function GitCommits(rs:Object = null) 
		{
			
		}
		
	}

}