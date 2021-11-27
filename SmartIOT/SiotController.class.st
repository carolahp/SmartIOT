Class {
	#name : #SiotController,
	#superclass : #Object,
	#category : #'SmartIOT-Controller'
}

{ #category : #'as yet unclassified' }
SiotController class >> getDeviceById: id [
	
	id asString = '1' ifTrue: [ ^ SiotDevice example1 ].
	id asString = '2' ifTrue: [ ^ SiotDevice example2 ].
	id asString = '3' ifTrue: [ ^ SiotDevice example3 ].
	
	self error: 'Got Stay id ', id asString, ', it should be 1 or 2 or 3'
]

{ #category : #'as yet unclassified' }
SiotController class >> getGuestById: id [
	id = 1 ifTrue: [ ^ SiotGuest example1 ].
	id = 2 ifTrue: [ ^ SiotGuest example2 ].
	self error: 'Guest id should be 1 or 2'
]

{ #category : #'as yet unclassified' }
SiotController class >> getHost [
	^ SiotHost example1
]

{ #category : #'as yet unclassified' }
SiotController class >> getMeasurementsForStay: stayID device: deviceID aiDissaggregation: bool [
	| stay device |
	
]

{ #category : #'as yet unclassified' }
SiotController class >> getStayById: id [
	
	id asString = '1' ifTrue: [ ^ SiotStay example1 ].
	id asString = '2' ifTrue: [ ^ SiotStay example2 ].
	self error: 'Got Stay id ', id asString, ', it should be 1 or 2'
]
