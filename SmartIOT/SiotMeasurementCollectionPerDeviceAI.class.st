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
	
	^ { 'fridge' . 'light' . 'sockets' . 'microwave' . 'dish washer' } collectWithIndex: [ :n :i | SiotDevice new id: i + 3; name: n; yourself  ]
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> input [ 
	^ (FileSystem workingDirectory / 'Dataset-Prediction'
	   / 'prediction.csv') contents
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> inputs [

	^ { self input }
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> loadData [ 
	| reader headers rows dataset |
	FullEnergyDataset ifNotNil: [ ^ self ].
	FullEnergyDataset := Array new: self devices size.
	
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
	self halt.
	self devices do: [:dev |
		
		dataset := (self new
			 device: dev name;
			 measurements: rows;
			 period: 1 second;
			 yourself).	
		  ].
	^ dataset
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceAI class >> resetEnergyDatasets [
	super resetEnergyDatasets.
	FullEnergyDataset := nil 
]
