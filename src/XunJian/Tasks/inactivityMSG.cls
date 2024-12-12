Class XunJian.Tasks.inactivityMSG Extends %Persistent
{

Property LastTime As %String;

Property BSNAME As %String;

Property Idletime As %Numeric;

Storage Default
{
<Data name="inactivityMSGDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>LastTime</Value>
</Value>
<Value name="3">
<Value>BSNAME</Value>
</Value>
<Value name="4">
<Value>Idletime</Value>
</Value>
</Data>
<DataLocation>^XunJian.Tasks.inactivityMSGD</DataLocation>
<DefaultData>inactivityMSGDefaultData</DefaultData>
<ExtentSize>6</ExtentSize>
<IdLocation>^XunJian.Tasks.inactivityMSGD</IdLocation>
<IndexLocation>^XunJian.Tasks.inactivityMSGI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="BSNAME">
<AverageFieldSize>27.67</AverageFieldSize>
<Selectivity>16.6667%</Selectivity>
</Property>
<Property name="Idletime">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:$c(0)</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="LastTime">
<AverageFieldSize>17.33</AverageFieldSize>
<Selectivity>20.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^XunJian.Tasks.inactivityMSGS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

