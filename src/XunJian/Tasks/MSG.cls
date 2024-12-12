Class XunJian.Tasks.MSG Extends %Persistent
{

Property Date1 As %String;

Property GetDisk As %String(MAXLEN = "");

Property GetCpu As %String(MAXLEN = "");

Property GetMem As %String(MAXLEN = "");

Property GetMessageLog As %String(MAXLEN = "");

Property GetLicenseInfo As %String(MAXLEN = "");

Property GetTasksStatus As %String(MAXLEN = "");

Property GetQueue As %String(MAXLEN = "");

Storage Default
{
<Data name="MSGDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Date1</Value>
</Value>
<Value name="3">
<Value>GetDisk</Value>
</Value>
<Value name="4">
<Value>GetCpu</Value>
</Value>
<Value name="5">
<Value>GetMem</Value>
</Value>
<Value name="6">
<Value>GetMessageLog</Value>
</Value>
<Value name="7">
<Value>GetLicenseInfo</Value>
</Value>
<Value name="8">
<Value>GetTasksStatus</Value>
</Value>
<Value name="9">
<Value>GetQueue</Value>
</Value>
</Data>
<DataLocation>^XunJian.Tasks.MSGD</DataLocation>
<DefaultData>MSGDefaultData</DefaultData>
<IdLocation>^XunJian.Tasks.MSGD</IdLocation>
<IndexLocation>^XunJian.Tasks.MSGI</IndexLocation>
<StreamLocation>^XunJian.Tasks.MSGS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

