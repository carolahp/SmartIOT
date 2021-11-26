Class {
	#name : #SiotPerson,
	#superclass : #Object,
	#instVars : [
		'id',
		'name'
	],
	#category : #'SmartIOT-Entities'
}

{ #category : #accessing }
SiotPerson >> id [

	^ id
]

{ #category : #accessing }
SiotPerson >> id: anObject [

	id := anObject
]

{ #category : #accessing }
SiotPerson >> name [

	^ name
]

{ #category : #accessing }
SiotPerson >> name: anObject [

	name := anObject
]
