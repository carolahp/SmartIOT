Class {
	#name : #SiotMeasurementCollection,
	#superclass : #Object,
	#instVars : [
		'measurements',
		'period'
	],
	#classInstVars : [
		'AllexDataset'
	],
	#category : #'SmartIOT-Measurements'
}

{ #category : #accessing }
SiotMeasurementCollection class >> examplePeriod1Day [

	| base |
	base := self examplePeriod1Second.
	^ self new
		  measurements: (base
				   from: base measurements first timestamp
				   to: base measurements last timestamp
				   period: (24*3600) seconds);
		  period: (24*3600) seconds;
		  yourself
]

{ #category : #accessing }
SiotMeasurementCollection class >> examplePeriod1Hour [

	| base |
	base := self examplePeriod1Second.
	^ self new
		  measurements: (base
				   from: base measurements first timestamp
				   to: base measurements last timestamp
				   period: 3600 seconds);
		  period: 3600 seconds;
		  yourself
]

{ #category : #accessing }
SiotMeasurementCollection class >> examplePeriod1Second [
	| reader headers rows |
	AllexDataset ifNotNil: [ ^ AllexDataset ].
	reader := self reader.
	headers := reader readHeader.
	rows := reader
		        skipHeader;
		        recordClass: SiotMeasurement;
		        addIntegerField: #timestamp:;
		        addIntegerField: #current:;
		        addIntegerField: #power:;
		        addIntegerField: #voltage:;
		        upToEnd.
	rows do: [ :row | 
		row timestamp: (self timestampFromSeconds: row timestamp) ].
	^ AllexDataset := self new
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

{ #category : #accessing }
SiotMeasurementCollection class >> secondsFromTimestamp: timestamp [
	^ timestamp asSeconds - 2177452800
]

{ #category : #accessing }
SiotMeasurementCollection class >> timestampFromSeconds: secs [
	^ DateAndTime fromSeconds: secs + 2177452800
]

{ #category : #formatting }
SiotMeasurementCollection >> from: t1 to: t2 [

	^ self measurements select: [ :m | m timestamp between: t1 and: t2 ]
]

{ #category : #accessing }
SiotMeasurementCollection >> from: t1 to: t2 period: p [
	| filtered result accumulatedPower pAsSecs |
	" ensure that the new period is divisible by the new period "
	
	self assert: p asSeconds % period asSeconds = 0.
	self assert: p > period.
	result := OrderedCollection new.
	filtered := self from: t1 to: t2.
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
