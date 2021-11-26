Class {
	#name : #SiotMeasurementCollection,
	#superclass : #Object,
	#instVars : [
		'measurements',
		'period'
	],
	#category : #'SmartIOT-Measurements'
}

{ #category : #accessing }
SiotMeasurementCollection class >> example1 [
	| reader headers rows |
	
	reader := self reader.
	headers := reader readHeader.
	rows := reader skipHeader;
		recordClass: SiotMeasurement;
		addIntegerField: #timestamp: ;
		addIntegerField: #current: ;
		addIntegerField: #power: ;
		addIntegerField: #voltage: ;
		upToEnd.
	rows do: [ :row | row convertTimestamp ].
	^ self new
		measurements: rows;
		period: 1 second;
		yourself 
]

{ #category : #accessing }
SiotMeasurementCollection class >> input [

	^ (FileSystem workingDirectory / 'Dataset-Allex-House'
	   / 'Main-Grid-Smart-Meter.csv') contents
]

{ #category : #accessing }
SiotMeasurementCollection class >> reader [
	^ NeoCSVReader on: self input readStream

]

{ #category : #formatting }
SiotMeasurementCollection >> getPowerFrom: t1 to: t2 [

	^ self measurements select: [ :m | m timestamp between: t1 and: t2 ]
]

{ #category : #accessing }
SiotMeasurementCollection >> getPowerFrom: t1 to: t2 period: p [
	| filtered result accumulatedPower pAsSecs |
	" ensure that the new period is divisible by the new period "
	
	self assert: p asSeconds % period asSeconds = 0.
	self assert: p > period.
	result := OrderedCollection new.
	filtered := self getPowerFrom: t1 to: t2.
	pAsSecs := p asSeconds.
	accumulatedPower := 0.
	filtered do: [ :m |
		m timestamp asSeconds % pAsSecs = 0 
			ifTrue: [ | newM |
				newM := SiotMeasurement new 
					power: accumulatedPower;
					timestamp: m timestamp;
					yourself.
				result add: newM.
				accumulatedPower := 0 ].
		accumulatedPower := accumulatedPower + (m power / period asSeconds).
	].
	^ result
]

{ #category : #accessing }
SiotMeasurementCollection >> measurements [

	^ measurements
]

{ #category : #accessing }
SiotMeasurementCollection >> measurements: anObject [

	measurements := anObject
]

{ #category : #accessing }
SiotMeasurementCollection >> period [

	^ period
]

{ #category : #accessing }
SiotMeasurementCollection >> period: anObject [

	period := anObject
]
