(:whc: this takes SubmissionData1.xml, which started as the xml form of SubmissionData.xslx but I had to copy/paste it into a new file so I could edit (nb neither of these is the same as SubmissionData.txt in contents) and creates a nodes table for Kumu, submission-nodes.csv, as output. It supercedes person-nodes-xquery-2.xquery.:)
xquery version "3.1";
declare option saxon:output "method=text";
declare variable $source := doc('relations1.xml');
declare variable $linefeed := "&#10;"; 

let $header := concat('Label,Type,Frequency',$linefeed)

let $submitters :=$source//sub
let $witnesses := $source//wit

let $persons := ($submitters | $witnesses)

let $output-rows :=
    for $person in $persons
    group by $distinct-name := $person=>string()
    let $frequency := $persons[string() = $distinct-name]=>count()

let $role :=
        if ($distinct-name = $source//sub) then "submitter"
        else "witness"  
    order by $frequency descending, $distinct-name
    return concat(replace($distinct-name, ',', ':'), ',', $role, ',', $frequency)
   
   return concat($header, string-join($output-rows, $linefeed))
    





