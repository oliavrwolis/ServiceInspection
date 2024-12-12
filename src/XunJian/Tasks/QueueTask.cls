Class XunJian.Tasks.QueueTask Extends %SYS.Task.Definition
{

Method OnTask() As %Status
{
	
	
	 	set time=$p($zdt($h,3),":",1)_":00:00"
	&sql(delete from XunJian_Tasks.QueueMSG where DateTime1<=:time)
	Set sqlStr="call Ens.Queue_Enumerate()"
    Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sqlStr)
    set DateTime1=$zdt($h,3)
    if qStatus'=1 {}
    #dim rset As %SQL.StatementResult = statement.%Execute()
    while rset.%Next(){
        set BSNAME=rset.%Get("Name")
        set QueueNum=rset.%Get("Count")
        
        &sql(insert into XunJian_Tasks.QueueMSG (BSNAME,QueueNum,DateTime1)values(:BSNAME,:QueueNum,:DateTime1))   
        if (QueueNum>^ServiceInspection("Queue","threshold")) &&(^ServiceInspection("Queue","Enable")="checked") 
        {
	        
	        Do ..SendWarnMessageToEmail()
	        
	    }  
    }
	
	Quit qStatus
}

Method SendWarnMessageToEmail() As %Status
{
	set date=$p($zdt($h,3),":",1)_":00:00"
	&sql(select count(1) into :num from XunJian_Tasks.EmailLog where Item='Queue' and DateTime1=:date)
	if num=0{
	set input=##class(Ens.AlertRequest).%New()
	set input.SourceConfigName=""
	set input.AlertText="Too many queues, please check in a timely manner"
	set input.AlertTime=$zdt($h,3)
	
	  Set BS =##class(XunJian.BS.SendEmail).%New("XunJian.BS.SendEmail")
       Set tSC=##class(Ens.Director).CreateBusinessService("XunJian.BS.SendEmail",.BS)
      
      
       Set tSC1=BS.ProcessInput(input,.output)
       &sql(insert into XunJian_Tasks.EmailLog (Item,DateTime1)values('Queue',:date))
	}
      qUIT $$$OK
}

}

