Class {
	#name : #SiotMeasurementCollectionPerDeviceNoAI,
	#superclass : #SiotMeasurementCollectionPerDevice,
	#category : #'SmartIOT-Measurements'
}

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceNoAI class >> input1 [

	^ (FileSystem workingDirectory / 'Dataset-Allex-House'
	   / 'Energy-Cooker.csv') contents
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceNoAI class >> input2 [

	^ (FileSystem workingDirectory / 'Dataset-Allex-House'
	   / 'Energy-TV-Living-Room.csv') contents
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceNoAI class >> input3 [

	^ (FileSystem workingDirectory / 'Dataset-Allex-House'
	   / 'Energy-Rack-Kitchen.csv') contents
]

{ #category : #'as yet unclassified' }
SiotMeasurementCollectionPerDeviceNoAI class >> inputs [

	^ { self input1 . self input2 . self input3 }
]
