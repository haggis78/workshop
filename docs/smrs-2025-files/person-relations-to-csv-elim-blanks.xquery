(:  declare default element namespace "http://www.tei-c.org/ns/1.0";  :)
(: whc: because the exported TEI is idiosyncratic, rather than trying to make it valid TEI, 
change the TEI root element to <root> and then just ignore the fact that it's otherwise TEI. :)
declare option saxon:output "method=text";
declare variable $linefeed := "&#10;";
concat("From, To, Relation",$linefeed,
string-join(

let $relations := //relation
[./data(@active) = //persName[@ana]/data(@xml:id)]
[./data(@passive) = //persName[@ana]/data(@xml:id)]  (:the predicates on $relations only allow through relationships between persons, excluding places and events:)

for $r in $relations

    let $r-act := $r/data(@active)
    let $r-pass := $r/data(@passive)
    let $r-type := $r/data(@name)
    let $r-act-name := //persName[./data(@xml:id) = $r-act]/data(@ana)
    let $r-pass-name := //persName[./data(@xml:id) = $r-pass]/data(@ana)
return concat($r-act-name!replace(., "#", ""), ", ", 
$r-pass-name!replace(., "#", ""),  ", ", $r-type!replace(., "_", " "), $linefeed)))
