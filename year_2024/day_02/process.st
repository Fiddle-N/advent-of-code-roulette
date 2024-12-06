| homeDir filePath content content2 regex newline reports difffn reportdiffs reportsafety reportsafetyint
 leveldiffer issafe part1 unsafereportsidx shamelesscopies shamelesscopy reportsafetydampening safecopies
 copydiffs reportsafetydampeningint part2 |

"Ran on Pharo 12.0 image (64 bit Windows)"

"For now this only works to pick a file on the home directory"
homeDir := FileLocator home.
filePath := homeDir / 'input.txt'.
content := filePath asFileReference readStream upToEnd.

newline := '<n>' expandMacros.
reports := content substrings: newline.
reports := reports collect: [:line | (line substrings: ' ') collect: [:level | level asInteger ]].

difffn := [
	:report | 
	(1 to: report size - 1) collect: [ 
		:i |
		(report at: i) - (report at: i + 1)
	]
].

reportdiffs := reports collect: difffn.

issafe := [ 
	: reportdiff |
	allsamesign := reportdiff allSatisfy: [ :each | each < 0].
	allsamesign := allsamesign or: [reportdiff allSatisfy: [ :each | each > 0]].
	
	leveldiffer := reportdiff allSatisfy: [ :each | each abs >= 1].
	leveldiffer := leveldiffer and: [reportdiff allSatisfy: [ :each | each abs <= 3]].
	
	allsamesign and: leveldiffer.
].

reportsafety := reportdiffs collect: issafe .
reportsafetyint := reportsafety collect: [ :safe | safe asInteger. ].

part1 := reportsafetyint sum .

Transcript show: 'Part 1: ', part1 asString , newline .


unsafereportsidx := (1 to: reports size) reject: [ 
	: index |
	(reportsafety at: index)
].

unsafereports := unsafereportsidx collect: [ 
	: index |
	reports at: index	
].

shamelesscopies := unsafereports collect: [ 
	: report |
	(1 to: report size) collect: [ 
		: index |
		shamelesscopy := report asOrderedCollection.
		shamelesscopy removeAt: index.
		shamelesscopy asArray.
	]
].

reportsafetydampening := shamelesscopies collect: [ 
	: copies | 
	copydiffs := copies collect: difffn.
	(copydiffs collect: issafe) anySatisfy: [ :each | each ]
].

reportsafetydampeningint := reportsafetydampening collect: [ :safe | safe asInteger. ].

part2 := part1 + (reportsafetydampeningint sum) .

Transcript show: 'Part 2: ', part2 asString .
