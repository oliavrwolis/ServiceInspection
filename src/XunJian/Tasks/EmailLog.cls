Class XunJian.Tasks.EmailLog Extends %Persistent
{

Property Item As %String;

Property DateTime1 As %String;

Storage Default
{
<Data name="EmailLogDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Item</Value>
</Value>
<Value name="3">
<Value>DateTime1</Value>
</Value>
</Data>
<DataLocation>^XunJian.Tasks.EmailLogD</DataLocation>
<DefaultData>EmailLogDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^XunJian.Tasks.EmailLogD</IdLocation>
<IndexLocation>^XunJian.Tasks.EmailLogI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="DateTime1">
<AverageFieldSize>21</AverageFieldSize>
<OutlierSelectivity>.999999:"2024-12-12 07:00:00"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Item">
<AverageFieldSize>7</AverageFieldSize>
<OutlierSelectivity>.999999:"Queue"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^XunJian.Tasks.EmailLogS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

