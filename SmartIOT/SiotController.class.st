Class {
	#name : #SiotController,
	#superclass : #Object,
	#category : #'SmartIOT-Controller'
}

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
SiotController class >> getStayById: id [
	
	id asString = '1' ifTrue: [ ^ SiotStay example1 ].
	id asString = '2' ifTrue: [ ^ SiotStay example2 ].
	self error: 'Got Stay id ', id asString, ', it should be 1 or 2'
]
