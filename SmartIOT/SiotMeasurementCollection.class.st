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
	| filtered |
	filtered := self getPowerFrom: t1 to: t2.
	
	
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
