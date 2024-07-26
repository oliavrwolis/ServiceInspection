Class XunJian.Tasks.Task Extends %SYS.Task.Definition
{

Method OnTask() As %Status
{
	Do ..t1()
    ////执行完保存到表
	quit $$$OK
}

ClassMethod t1() As %Status
{
	
	
    set date=$zdt($h,3)
    w date,!
	set disk= ##class(XunJian.Tasks.Util).GetDisk().%ToJSON()
	set GetCpu= ##class(XunJian.Tasks.Util).GetCpu().%ToJSON()
	set GetMem= ##class(XunJian.Tasks.Util).GetMem().%ToJSON()
	set GetMessageLog= ##class(XunJian.Tasks.Util).GetMessageLog().%ToJSON()
	set GetLicenseInfo= ##class(XunJian.Tasks.Util).GetLicenseInfo().%ToJSON()
	set GetTasksStatus= ##class(XunJian.Tasks.Util).GetTasksStatus().%ToJSON()
	set GetQueue= ##class(XunJian.Tasks.Util).GetQueue().%ToJSON()
	
   
	&sql(insert into XunJian_Tasks.MSG (Date1,GetDisk,GetCpu,GetMem,GetMessageLog,GetLicenseInfo,GetTasksStatus,GetQueue)
	values(:date,:disk,:GetCpu,:GetMem,:GetMessageLog,:GetLicenseInfo,:GetTasksStatus,:GetQueue))
	Quit $$$OK
}

}

