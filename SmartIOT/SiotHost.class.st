Class {
	#name : #SiotHost,
	#superclass : #SiotPerson,
	#instVars : [
		'stays'
	],
	#category : #'SmartIOT-Entities'
}

{ #category : #examples }
SiotHost class >> example1 [ 
	^ self new
		id: 1;
		name: 'Allex Oliveira';
		yourself
]
