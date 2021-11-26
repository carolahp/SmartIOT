Class {
	#name : #SiotMeasurement,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'current',
		'power',
		'voltage'
	],
	#category : #'SmartIOT-Entities'
}

{ #category : #examples }
SiotMeasurement class >> example1 [
	| ts |
	ts := DateAndTime
		      year: 2012
		      month: 2
		      day: 14
		      hour: 16
		      minute: 40
		      second: 18
		      offset: 1 hour.

	^ self new
		  timestamp: ts;
		  current: 200.003212;
		  power: 888.000988;
		  voltage: 999.004343;
		  yourself
]

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
		          mapper for: self class do: [ :mapping | 
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
