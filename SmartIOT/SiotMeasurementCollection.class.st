Class {
	#name : #SiotMeasurementCollection,
	#superclass : #Object,
	#instVars : [
		'measurements'
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
	rows do: [ :row | row convertTimestamp ]
]

{ #category : #accessing }
SiotMeasurementCollection class >> input [

	^ (FileSystem workingDirectory / 'Dataset-Allex-House'
	   / 'Main-Grid-Smart-Meter-cut.csv') contents
]

{ #category : #accessing }
SiotMeasurementCollection class >> reader [
	^ NeoCSVReader on: self input readStream

]
