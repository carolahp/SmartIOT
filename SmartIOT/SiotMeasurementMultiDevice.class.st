Class {
	#name : #SiotMeasurementMultiDevice,
	#superclass : #Object,
	#instVars : [
		'fridge',
		'light',
		'sockets',
		'microwave',
		'dishwasher',
		'timestamp'
	],
	#category : #'SmartIOT-Measurements'
}

{ #category : #accessing }
SiotMeasurementMultiDevice >> dishwasher [

	^ dishwasher
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> dishwasher: anObject [

	dishwasher := anObject
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> fridge [

	^ fridge
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> fridge: anObject [

	fridge := anObject
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> light [

	^ light
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> light: anObject [

	light := anObject
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> microwave [

	^ microwave
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> microwave: anObject [

	microwave := anObject
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> sockets [

	^ sockets
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> sockets: anObject [

	sockets := anObject
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> timestamp [

	^ timestamp
]

{ #category : #accessing }
SiotMeasurementMultiDevice >> timestamp: anObject [

	timestamp := anObject
]
