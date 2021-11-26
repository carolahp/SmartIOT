Class {
	#name : #BaselineOfSmartIOT,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmartIOT
}

{ #category : #initialization }
BaselineOfSmartIOT >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec package: 'SmartIOT' with: [ spec requires: #('Teapot') ] ]
]

{ #category : #initialization }
BaselineOfSmartIOT >> setUpDependencies: spec [

	spec
		baseline: 'Teapot'
			with: [ spec
				repository: 'github://zeroflag/Teapot:v2.6.0/source';
				loads: #('Deployment') ];
		import: 'Teapot'.
	spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
	spec baseline: 'NeoCSV' with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].

]
