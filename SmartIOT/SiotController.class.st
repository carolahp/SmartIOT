Class {
	#name : #SiotController,
	#superclass : #Object,
	#category : #'SmartIOT-Controller'
}

{ #category : #'as yet unclassified' }
SiotController >> getGuestById: id [
	id = 1 ifTrue: [ ^ SiotGuest example1 ].
	id = 2 ifTrue: [ ^ SiotGuest example2 ].
	self error: 'Guest id should be 1 or 2'
]

{ #category : #'as yet unclassified' }
SiotController >> getHost [
	^ SiotHost example1
]
