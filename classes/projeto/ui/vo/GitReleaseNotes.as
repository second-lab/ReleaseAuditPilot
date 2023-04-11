package projeto.ui.vo 
{
	
	import projeto.ui.vo.GitBranch;
	
	/**
	 * ...
	 * @author Luiz Segundo
	 */
	public class GitReleaseNotes extends Object
	{
		
		private var key :String;
		private var name:String;
		private var version:String;
		private var versionOrderBy:String; //can be used to order git label menu
		private var gitHead:GitBranch;
		private var gitMergeBase:GitBranch;
		private var arrCommits:Array;
		private var arrCommitsNotFoundinJira:Array;
	
		public function get Key ():String { return key; }
		
		public function set Key(value:String):void 
		{
			key = value;
		}
		
		public function get GitHead ():GitBranch 
		{
			if (gitHead == null) gitHead  = new GitBranch();
			return gitHead; 
			
		}
		
		public function set GitHead(value:GitBranch):void 
		{
			gitHead = value;
		}	
		
		public function get GitMergeBase ():GitBranch { return gitMergeBase; }
		
		public function set GitMergeBase(value:GitBranch):void 
		{
			gitMergeBase = value;
		}
		
		public function get Name ():String { return name; }
		
		public function set Name(value:String):void 
		{
			name = value;
		}
		
		
		public function get Version ():String { return version; }
		
		public function set Version(value:String):void 
		{
			version = value;
		}
		
		public function get VersionOrderBy ():String { return versionOrderBy; }
		
		public function set VersionOrderBy(value:String):void 
		{
			versionOrderBy = value;
		}
		
		public function get ArrCommits ():Array { return arrCommits; }
		
		public function set ArrCommits(value:Array):void 
		{
			arrCommits = value;
		}
		
		public function get ArrCommitsFoundinJira():Array { return arrCommitsNotFoundinJira; }
		
		public function set ArrCommitsFoundinJira(value:Array):void 
		{
			arrCommitsNotFoundinJira = value;
		}
	
		
		public function GitReleaseNotes(rs:Object = null) 
		{
			
		}
		
	}

}