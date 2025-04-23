(:whc: This has been superceded by person-nodes-xquery-2.xquery.

This takes SubmissionData1.xml, which started as the xml form of SubmissionData.xslx but I had to copy/paste it into a new file so I could edit (nb neither of these is the same as SubmissionData.txt in contents) and creates a nodes table for Kumu, submission-nodes.csv, as output. :)
xquery version "3.1";
declare option saxon:output "method=text";
declare variable $node-source := doc('SubmissionData1.xml');
declare variable $linefeed := "&#10;"; 

let $header := concat('Name,Role,Frequency',$linefeed)

let $persons := $node-source//Row[position()!=1]
let $output-rows :=
    for $person in $persons
    group by $distinct-name := $person//Cell[3]//Data
    let $frequency := $persons[.//Data = $distinct-name]=>count()
    (:whc: the [1] in the next line is because there seems to be a person with more than one role; this filters for only the first role a person has. This thus fudges the data a bit. If doing anything official with this, I would need to change the FLWOR statement to get unique combinations of person name and role. :)
    let $role := $person[.//Cell[3]//Data = $distinct-name][1]//Cell[4]/Data
    order by $frequency descending, $distinct-name
    return concat(replace($distinct-name, ',', ':'), ',', $role, ',', $frequency)
   
   return concat($header, string-join($output-rows, $linefeed))
    





