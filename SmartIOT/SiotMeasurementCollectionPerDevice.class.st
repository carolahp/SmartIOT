Class {
	#name : #SiotMeasurementCollectionPerDevice,
	#superclass : #SiotMeasurementCollection,
	#instVars : [
		'device'
	],
	#classInstVars : [
		'EnergyDatasets'
	],
	#category : #'SmartIOT-Measurements'
}

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> example1Period1Second [
	
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> examplePeriod1Second: deviceID [
	| reader headers rows |
	
	EnergyDatasets ifNil: [ EnergyDatasets := Array new: 3 ].
	(EnergyDatasets at: deviceID) ifNotNil: [ ^ EnergyDatasets at: deviceID ].
	
	reader := NeoCSVReader on: (self inputs at: deviceID) readStream.
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
	EnergyDatasets at: deviceID put: (self new
		  measurements: rows;
		  period: 1 second;
		  yourself).
	^ EnergyDatasets at: deviceID
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> input1 [

	^ (FileSystem workingDirectory / 'Dataset-Allex-House'
	   / 'Energy-Cooker.csv') contents
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> input2 [

	^ (FileSystem workingDirectory / 'Dataset-Allex-House'
	   / 'Energy-TV-Living-Room.csv') contents
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> input3 [

	^ (FileSystem workingDirectory / 'Dataset-Allex-House'
	   / 'Energy-Rack-Kitchen.csv') contents
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> inputs [

	^ { self input1 . self input2 . self input3 }
]

{ #category : #serialization }
SiotMeasurementCollectionPerDevice >> serializeToJson [

	| writer |
	writer := [ :object | 
	          String streamContents: [ :stream | 
		          | mapper |
		          mapper := NeoJSONWriter on: stream.
		          mapper for: self class do: [ :mapping | 
						mapping mapInstVars: #( device ).
			          (mapping mapInstVar: #measurements) valueSchema:
				          #ArrayOfMeasurements ].
		          mapper
			          for: #ArrayOfMeasurements
			          customDo: [ :mapping | 
				          mapping listOfElementSchema: SiotMeasurement ];
			          for: SiotMeasurement do: [ :mapping | 
				          (mapping mapInstVar: #timestamp) valueSchema:
						          DateAndTime.
				          mapping mapInstVars: #( current power voltage ) ].
		          mapper for: DateAndTime customDo: [ :mapping | 
			          mapping decoder: [ :string | 
				          DateAndTime fromString: string ].
			          mapping encoder: [ :dateAndTime | 
				          dateAndTime printString ] ].

		          mapper nextPut: object ] ].
	^ writer value: self
]
