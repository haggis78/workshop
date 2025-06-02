(:  declare default element namespace "http://www.tei-c.org/ns/1.0";  :)
(: whc: because the exported TEI is idiosyncratic, rather than trying to make it valid TEI, 
change the TEI root element to <root> and then just ignore the fact that it's otherwise TEI. :)
declare option saxon:output "method=text";
declare variable $linefeed := "&#10;";

concat("Label,Entity,Frequency,Degree,In-degree,Out-degree",$linefeed,
string-join(
let $persons := //text//persName[@ana]/data(@ana)!replace(., "#", "")
for $person in $persons=>distinct-values()
    let $frequency := count(//text//persName[./data(@ana)!replace(., "#", "") = $person])
    let $in-degree := count(//text//persName[./data(@ana)!replace(., "#", "") = $person][./data(@xml:id) = //relation/data(@passive)])
    let $out-degree := count(//text//persName[./data(@ana)!replace(., "#", "") = $person][./data(@xml:id) = //relation/data(@active)])
    let $degree := $in-degree + $out-degree
    order by $frequency descending
return concat($person, ",Person,",$frequency,",",$degree, ",",$in-degree, ",",$out-degree, $linefeed)))



