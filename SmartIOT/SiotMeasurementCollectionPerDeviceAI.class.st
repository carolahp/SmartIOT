Class {
	#name : #SiotMeasurementCollectionPerDeviceAI,
	#superclass : #SiotMeasurementCollectionPerDevice,
	#classInstVars : [
		'FullEnergyDataset'
	],
	#category : #'SmartIOT-Measurements'
}

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> devices [
	
	^ { 'fridge' . 'light' . 'sockets' . 'microwave' . 'dishwasher' } collectWithIndex: [ :n :i | SiotDevice new id: i + 3; name: n; yourself  ]
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> input [
	"(ZnEasy get: 'http://localhost:1701/dissagregatedRealPerHour/stayID/3/deviceID/1/useAI/1') entity string." 
	^ (FileSystem workingDirectory / 'Dataset-Prediction'
	   / 'prediction.csv') contents
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> inputs [

	^ { self input }
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> loadData [

	| reader headers rows measurementCollections |
	FullEnergyDataset ifNotNil: [ ^ self ].

	reader := NeoCSVReader on: self input readStream.
	headers := reader readHeader.
	rows := reader
		        skipHeader;
		        recordClass: SiotMeasurementMultiDevice;
		        addIntegerField: #fridge:;
		        addIntegerField: #light:;
		        addIntegerField: #sockets:;
		        addIntegerField: #microwave:;
		        addIntegerField: #dishwasher:;
		        addIntegerField: #timestamp:;
		        upToEnd.
	rows do: [ :row | 
		row timestamp: (self timestampFromSeconds: row timestamp) ].
	
	measurementCollections := (self devices collect: [ :dev | 
		         							dev name ->                 
											(self new
			                          device: dev name;
			                          period: 60 second;
			                          measurements: OrderedCollection new;
			                          yourself) ]) asDictionary.

	rows do: [ :row | 
		self devices do: [ :dev | 
			| measurement |
			measurement := SiotMeasurement new
				               timestamp: row timestamp;
				               power: (row powerForDevice: dev);
				               yourself.
			(measurementCollections at: dev name) measurements add: measurement ] ].
	EnergyDatasets := Array new: self devices size.
	measurementCollections doWithIndex: [ :each : index |
		EnergyDatasets at: index put: (self new
			 device: each device;
			 measurements: each measurements;
			 period: 60 second;
			 yourself)
		 ].
	^ EnergyDatasets
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> resetEnergyDatasets [
	super resetEnergyDatasets.
	FullEnergyDataset := nil 
]
