Class {
	#name : #SiotStay,
	#superclass : #Object,
	#instVars : [
		'guestID',
		'from',
		'to'
	],
	#category : #'SmartIOT-Entities'
}

{ #category : #examples }
SiotStay class >> example1 [
	^ self new
		guestID: 1;
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

{ #category : #accessing }
SiotStay >> from [

	^ from
]

{ #category : #accessing }
SiotStay >> from: anObject [

	from := anObject
]

{ #category : #accessing }
SiotStay >> guestID [

	^ guestID
]

{ #category : #accessing }
SiotStay >> guestID: anObject [

	guestID := anObject
]

{ #category : #accessing }
SiotStay >> to [

	^ to
]

{ #category : #accessing }
SiotStay >> to: anObject [

	to := anObject
]
