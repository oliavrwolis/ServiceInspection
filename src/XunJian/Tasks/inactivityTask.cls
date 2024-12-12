Class XunJian.Tasks.inactivityTask Extends %SYS.Task.Definition
{

Method OnTask() As %Status
{
	

    ///入参当日调用数量及最新一次调用时间
    ///
   
    set sql="select * from Ens_Config.Item"
    Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sql)
   // w sql
    if qStatus'=1 {}
    
    SET WDate=$p($system.SQL.DATEADD("H",1,$zdt($h,3)),":",1)_":00:00"
    #dim rset As %SQL.StatementResult = statement.%Execute()
    while rset.%Next(){
	     set name=rset.%Get("Name")
	     set TimeCreated=""
	     &sql(select top 1 TimeCreated into :TimeCreated from Ens.MessageHeader where SourceConfigName=:name order by TimeCreated  desc)
	     &sql(select count(1) into :num from XunJian_Tasks.inactivityMSG where  BSNAME =:name)
	     
        if (num=0)||(num=""){
	        
	      &sql(insert into XunJian_Tasks.inactivityMSG (LastTime,BSNAME,Idletime)values(:TimeCreated,:name,''))
        }else{
	        SET TIMEDIFF=$system.SQL.DATEDIFF("ss",TimeCreated,$zdt($h,3))
	  
	        if (TIMEDIFF>^ServiceInspection("inactivity","threshold")) &&(^ServiceInspection("inactivity","Enable")="checked") 
	        {
		      Do ..SendWarnMessageToEmail()   
		     }
	       // w TIMEDIFF,!
	      &sql(update XunJian_Tasks.inactivityMSG (LastTime,Idletime)values(:TimeCreated,:TIMEDIFF) WHERE BSNAME= :name)  
	     }
	     
	     
    }
	Quit qStatus
}

Method SendWarnMessageToEmail() As %Status
{
	set date=$p($zdt($h,3),":",1)_":00:00"
	&sql(select count(1) into :num from XunJian_Tasks.EmailLog where Item='inactivity' and DateTime1=:date)
	if num=0{
	set input=##class(Ens.AlertRequest).%New()
	set input.SourceConfigName=""
	set input.AlertText="Non activity time is too long, please check"
	set input.AlertTime=$zdt($h,3)
	
	  Set BS =##class(XunJian.BS.SendEmail).%New("XunJian.BS.SendEmail")
       Set tSC=##class(Ens.Director).CreateBusinessService("XunJian.BS.SendEmail",.BS)
      
      
       Set tSC1=BS.ProcessInput(input,.output)
       &sql(insert into XunJian_Tasks.EmailLog (Item,DateTime1)values('inactivity',:date))
	}
      qUIT $$$OK
}

}

