package projeto.ui.vo 
{
	
	
	import projeto.ui.vo.GitBranch;
	
	/**
	 * ...
	 * @author Luiz Segundo
	 */
	public class SWAudit extends Object
	{
		
		private var key :String;
		private var name:String;
		private var version:String;
		private var branch_name:String;
		private var branchSearchKey:String;
		
		private var arrJiraIssues:Array;
		private var arrGitIssues:Array;
		private var arrReleaseNotes:Array;
		private var arrTagReleaseNotes:Array;
		private var arrGitBranches:Array;
		private var arrGitTags:Array;
		
		private var gitHead:GitBranch;
		private var gitRC:GitBranch;
		
		private var hashMergebase:String;
	
		public function get HashMergebase ():String { return hashMergebase; }
		
		public function set HashMergebase(value:String):void 
		{
			hashMergebase = value;
		}
		
		public function get Key ():String { return key; }
		
		public function set Key(value:String):void 
		{
			key = value;
		}
		
		public function get Name ():String { return name; }
		
		public function set Name(value:String):void 
		{
			name = value;
		}
		
		public function get BranchName ():String { return branch_name; }
		
		public function set BranchName(value:String):void 
		{
			branch_name = value;
		}
		
		public function get Version ():String { return version; }
		
		public function set Version(value:String):void 
		{
			version = value;
		}
		
		public function get BranchSearchKey ():String { return branchSearchKey; }
		
		public function set BranchSearchKey(value:String):void 
		{
			branchSearchKey = value;
		}
		
		public function get ArrJiraIssues ():Array { return arrJiraIssues; }
		
		public function set ArrJiraIssues(value:Array):void 
		{
			arrJiraIssues = value;
		}
		
		public function get ArrGitIssues ():Array { return arrGitIssues; }
		
		public function set ArrGitIssues(value:Array):void 
		{
			arrGitIssues = value;
		}
		
		public function get ArrGitTags ():Array { return arrGitTags; }
		
		public function set ArrGitTags(value:Array):void 
		{
			arrGitTags = value;
		}
		
		public function get ArrReleaseNotes ():Array { return arrReleaseNotes; }
		
		public function set ArrReleaseNotes(value:Array):void 
		{
			arrReleaseNotes = value;
		}
		
		public function get ArrTagReleaseNotes ():Array { return arrTagReleaseNotes; }
		
		public function set ArrTagReleaseNotes(value:Array):void 
		{
			arrTagReleaseNotes = value;
		}
		
		public function get ArrGitBranches ():Array { return arrGitBranches; }
		
		public function set ArrGitBranches(value:Array):void 
		{
			arrGitBranches = value;
		}
		
		public function get GitHead ():GitBranch { return gitHead; }
		
		public function set GitHead(value:GitBranch):void 
		{
			gitHead = value;
		}
		
		public function get GitRC ():GitBranch { return gitRC; }
		
		public function set GitRC(value:GitBranch):void 
		{
			gitRC = value;
		}
		
		
		public function OSWAudit(rs:Object = null):void 
		{
			for (var i:String in rs)
			{
				if (i == "rnotes") 
				{
					arrReleaseNotes = new Array(rs[i]);
				}
				else if (i == "jiraissues")
				{
					arrJiraIssues = new Array(rs[i]);
				}
				else if (i == "branches")
				{
					arrGitBranches = new Array(rs[i]);
				}
				else
				{
					this[i] = rs[i];
				}
			}
		}
		
	}

}