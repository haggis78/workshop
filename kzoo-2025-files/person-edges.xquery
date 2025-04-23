xquery version "3.1";
declare option saxon:output "method=text";
declare variable $node-source := doc('SubmissionData1.xml');
declare variable $edge-source :=doc('relations1.xml');
declare variable $linefeed := "&#10;"; 

let $header := concat('From,To',$linefeed)

let $submitters :=$edge-source//sub=>distinct-values()

let $relations :=
for $sub in $submitters
    let $sub-wits := $edge-source//Row[.//sub=$sub]//wit
    for $sub-wit in $sub-wits
    return concat(replace($sub, ',', ':'),',',replace($sub-wit, ',', ':'))
    
    return concat($header, string-join($relations, $linefeed))