Class {
	#name : #SiotMeasurement,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'current',
		'power',
		'voltage'
	],
	#category : #SmartIOT
}

{ #category : #accessing }
SiotMeasurement >> current [

	^ current
]

{ #category : #accessing }
SiotMeasurement >> current: anObject [

	current := anObject
]

{ #category : #accessing }
SiotMeasurement >> power [

	^ power
]

{ #category : #accessing }
SiotMeasurement >> power: anObject [

	power := anObject
]

{ #category : #serialization }
SiotMeasurement >> serializeToJson [

	| writer |
	writer := [ :object | 
	          String streamContents: [ :stream | 
		          | mapper |
		          mapper := NeoJSONWriter on: stream.
		          mapper for: SiotMeasurement do: [ :mapping | 
			          (mapping mapInstVar: #timestamp) valueSchema: DateAndTime.
			          mapping mapInstVars: #( current power voltage ) ].
		          mapper for: DateAndTime customDo: [ :mapping | 
			          mapping decoder: [ :string | 
				          DateAndTime fromString: string ].
			          mapping encoder: [ :dateAndTime | 
				          dateAndTime printString ] ].
		          mapper nextPut: object ] ].
	^ writer value: self
]

{ #category : #accessing }
SiotMeasurement >> timestamp [

	^ timestamp
]

{ #category : #accessing }
SiotMeasurement >> timestamp: anObject [

	timestamp := anObject
]

{ #category : #accessing }
SiotMeasurement >> voltage [

	^ voltage
]

{ #category : #accessing }
SiotMeasurement >> voltage: anObject [

	voltage := anObject
]
