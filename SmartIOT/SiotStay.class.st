Class {
	#name : #SiotStay,
	#superclass : #Object,
	#instVars : [
		'id',
		'guest',
		'from',
		'to',
		'numGuests'
	],
	#category : #'SmartIOT-Entities'
}

{ #category : #examples }
SiotStay class >> example1 [
	^ self new
		id: 1;
		numGuests: 3;
		guest: SiotGuest example1;
		from: (DateAndTime
		      year: 2021
		      month: 11
		      day: 14
		      hour: 10
		      minute: 40
		      second: 00
		      offset: 1 hour);
		to: (DateAndTime
		      year: 2021
		      month: 11
		      day: 18
		      hour: 18
		      minute: 00
		      second: 00
		      offset: 1 hour);
		yourself
]

{ #category : #examples }
SiotStay class >> example2 [
	^ self new
		id: 2;
		numGuests: 5;
		guest: SiotGuest example2;
		from: (DateAndTime
		      year: 2021
		      month: 11
		      day: 19
		      hour: 10
		      minute: 40
		      second: 00
		      offset: 1 hour);
		to: (DateAndTime
		      year: 2021
		      month: 11
		      day: 25
		      hour: 18
		      minute: 00
		      second: 00
		      offset: 1 hour);
		yourself
]

{ #category : #accessing }
SiotStay >> from [

	^ from
]

{ #category : #accessing }
SiotStay >> from: anObject [

	from := anObject
]

{ #category : #accessing }
SiotStay >> guest [

	^ guest
]

{ #category : #accessing }
SiotStay >> guest: anObject [

	guest := anObject
]

{ #category : #accessing }
SiotStay >> id [

	^ id
]

{ #category : #accessing }
SiotStay >> id: anObject [

	id := anObject
]

{ #category : #accessing }
SiotStay >> numGuests [

	^ numGuests
]

{ #category : #accessing }
SiotStay >> numGuests: anObject [

	numGuests := anObject
]

{ #category : #serialization }
SiotStay >> serializeToJson [
	| writer |
	writer := [ :object | 
	          String streamContents: [ :stream | 
		          | mapper |
		          mapper := NeoJSONWriter on: stream.
		          mapper for: self class do: [ :mapping | 
			         (mapping mapInstVar: #from) valueSchema: DateAndTime.
						(mapping mapInstVar: #to) valueSchema: DateAndTime.
			          mapping mapInstVars: #( id numGuests ) ].
		          mapper for: DateAndTime customDo: [ :mapping | 
			          mapping decoder: [ :string | 
				          DateAndTime fromString: string ].
			          mapping encoder: [ :dateAndTime | 
				          dateAndTime printString ] ].
		          mapper nextPut: object ] ].
	^ writer value: self
]

{ #category : #accessing }
SiotStay >> to [

	^ to
]

{ #category : #accessing }
SiotStay >> to: anObject [

	to := anObject
]
