Class XunJian.Tasks.MsgTask Extends %SYS.Task.Definition
{

Method OnTask() As %Status
{
	

    ///入参当日调用数量及最新一次调用时间
    ///
    set date=$p($zdt($h,3),":",1)_":00:00"
    set sql="select SourceConfigName,count(1) as num from Ens.MessageHeader  where TimeCreated >'"_date_"' and SourceBusinessType ='1' group by SourceConfigName order by TimeCreated desc"
    Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sql)
   // w sql
    if qStatus'=1 {}
    SET WDate=$p($system.SQL.DATEADD("H",1,$zdt($h,3)),":",1)_":00:00"
    #dim rset As %SQL.StatementResult = statement.%Execute()
    while rset.%Next(){
	   // w "--",!
        set BSNAME=rset.%Get("SourceConfigName")
        set MsgNum=rset.%Get("num")
        set num=0
        &sql(select count(1) into :num from XunJian_Tasks.MessageNumMSG where DateTime1=:WDate and BSNAME =:BSNAME)
        if (num=0){
        &sql(insert into XunJian_Tasks.MessageNumMSG (BSNAME,MsgNum,DateTime1)values(:BSNAME,:MsgNum,:WDate))    
        }else{
	       &sql(update XunJian_Tasks.MessageNumMSG (MsgNum)values(:MsgNum) where DateTime1=:WDate and BSNAME =:BSNAME)    
         
	    }   
	    if (MsgNum>^ServiceInspection("traffic per hour","threshold")) &&(^ServiceInspection("traffic per hour","Enable")="checked") 
        {
	        
	        Do ..SendWarnMessageToEmail()
	        
	    } 
    }
	Quit qStatus
}

Method SendWarnMessageToEmail() As %Status
{
	set date=$p($zdt($h,3),":",1)_":00:00"
	&sql(select count(1) into :num from XunJian_Tasks.EmailLog where Item='traffic per hour' and DateTime1=:date)
	if num=0{
	set input=##class(Ens.AlertRequest).%New()
	set input.SourceConfigName=""
	set input.AlertText="Excessive hourly traffic volume, please check"
	set input.AlertTime=$zdt($h,3)
	
	  Set BS =##class(XunJian.BS.SendEmail).%New("XunJian.BS.SendEmail")
       Set tSC=##class(Ens.Director).CreateBusinessService("XunJian.BS.SendEmail",.BS)
      
      
       Set tSC1=BS.ProcessInput(input,.output)
       &sql(insert into XunJian_Tasks.EmailLog (Item,DateTime1)values('traffic per hour',:date))
	}
      qUIT $$$OK
}

}

