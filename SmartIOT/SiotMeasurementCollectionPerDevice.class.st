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
SiotMeasurementCollectionPerDevice class >> energyDatasets [
	^ EnergyDatasets 
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> examplePeriod1Day: deviceID from: t1 to: t2 [

	| base |
	base := self examplePeriod1Second: deviceID.
	^ self new
		  device: (SiotController getDeviceById: deviceID) name;
		  measurements: (base from: t1 to: t2 period: (24 * 3600) seconds);
		  period: (24 * 3600) seconds;
		  yourself
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> examplePeriod1Hour: deviceID from: t1 to: t2 [

	| base |
	base := self examplePeriod1Second: deviceID.
	^ self new
		  device: (SiotController getDeviceById: deviceID) name;
		  measurements: (base from: t1 to: t2 period: 3600 seconds);
		  period: 3600 seconds;
		  yourself
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> examplePeriod1Second: deviceID [

	| reader headers rows |
	EnergyDatasets ifNil: [ EnergyDatasets := Array new: self inputs size ].
	(EnergyDatasets at: deviceID) ifNotNil: [ 
		^ EnergyDatasets at: deviceID ].

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
			 device: (SiotController getDeviceById: deviceID) name;
			 measurements: rows;
			 period: 1 second;
			 yourself).
	^ EnergyDatasets at: deviceID
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> inputs [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDevice class >> resetEnergyDatasets [
	EnergyDatasets := nil 
]

{ #category : #accessing }
SiotMeasurementCollectionPerDevice >> device [

	^ device
]

{ #category : #accessing }
SiotMeasurementCollectionPerDevice >> device: anObject [

	device := anObject
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
